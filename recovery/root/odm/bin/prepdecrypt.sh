#!/sbin/sh

# ==============================================================================
# prepdecrypt.sh - Xiaomi Myron (K90 Pro Max)
# Android 16 / FBE v2 / A/B (_b) / 动态分区 / erofs
# ==============================================================================

SCRIPTNAME="prepdecrypt"
LOGFILE=/tmp/recovery.log
DEFAULT_LOGLEVEL=1

# 退出码
# 0 成功
# 1 出错（但会强制设置 crypto.ready=1 以保证安全）

# --------------------------------------------------------------
# 日志记录函数
# --------------------------------------------------------------
log_print() {
    case $1 in
        0|error) LOG_LEVEL="E" ;;
        1|info)  LOG_LEVEL="I" ;;
        2|debug) LOG_LEVEL="DEBUG" ;;
        *)       LOG_LEVEL="UNKNOWN" ;;
    esac
    if [ "${__VERBOSE:-$DEFAULT_LOGLEVEL}" -ge "$1" ]; then
        echo "$LOG_LEVEL:$SCRIPTNAME::$2" >> "$LOGFILE"
    fi
}

# --------------------------------------------------------------
# 挂载辅助函数（自动识别 erofs）
# --------------------------------------------------------------
do_mount() {
    local mnt="$1"
    local dev="$2"
    local name="$3"
    
    mkdir -p "$mnt"
    
    # 优先尝试 erofs（真机已验证），否则自动检测
    if mount -o ro -t erofs "$dev" "$mnt" 2>/dev/null; then
        log_print 1 "$name 以 erofs 挂载成功"
        return 0
    elif mount -o ro "$dev" "$mnt" 2>/dev/null; then
        log_print 1 "$name 以自动检测格式挂载成功"
        return 0
    else
        log_print 0 "挂载 $name 失败，设备: $dev"
        return 1
    fi
}

# --------------------------------------------------------------
# 获取系统属性（优先使用 resetprop）
# --------------------------------------------------------------
get_prop() {
    if [ -e /sbin/resetprop ]; then
        resetprop "$1"
    else
        getprop "$1"
    fi
}

# --------------------------------------------------------------
# 主流程
# --------------------------------------------------------------

log_print 1 "开始执行 $SCRIPTNAME (Myron / Android 16 / FBE v2 / erofs)"

# 检测日志级别
CUSTOM_LOGLEVEL=$(get_prop "$SCRIPTNAME.loglevel")
__VERBOSE="${CUSTOM_LOGLEVEL:-$DEFAULT_LOGLEVEL}"

# --------------------------------------------------------------
# 1. 检测 A/B 槽位（真机当前为 _b）
# --------------------------------------------------------------
slot_suffix=$(get_prop ro.boot.slot_suffix)
if [ -z "$slot_suffix" ]; then
    # 兼容旧属性名
    slot=$(get_prop ro.boot.slot)
    [ -n "$slot" ] && slot_suffix="_$slot"
fi
log_print 1 "当前 A/B 槽位后缀: '$slot_suffix'"

# --------------------------------------------------------------
# 2. 检测动态分区支持（真机为 true）
# --------------------------------------------------------------
dynamic_partitions=$(get_prop ro.boot.dynamic_partitions)
if [ "$dynamic_partitions" = "true" ]; then
    log_print 1 "动态分区已启用"
else
    log_print 1 "动态分区未启用，将使用 by-name 路径"
fi

# --------------------------------------------------------------
# 3. 挂载 vendor 分区并提取关键属性
# --------------------------------------------------------------
VENDOR_MNT=/v
VENDOR_DEV=""

# 优先使用动态分区路径
if [ "$dynamic_partitions" = "true" ] && [ -e "/dev/block/mapper/vendor$slot_suffix" ]; then
    VENDOR_DEV="/dev/block/mapper/vendor$slot_suffix"
else
    VENDOR_DEV="/dev/block/bootdevice/by-name/vendor$slot_suffix"
fi

log_print 1 "vendor 设备路径: $VENDOR_DEV"

if [ -e "$VENDOR_DEV" ]; then
    if do_mount "$VENDOR_MNT" "$VENDOR_DEV" "vendor"; then
        
        # --------------------------------------------------------------
        # 3.1 提取并设置 ro.vendor.build.security_patch
        # --------------------------------------------------------------
        for prop_file in "$VENDOR_MNT/build.prop" "$VENDOR_MNT/etc/build.prop"; do
            if [ -f "$prop_file" ]; then
                ven_sec_patch=$(grep -m 1 'ro.vendor.build.security_patch=' "$prop_file" | cut -d'=' -f2-)
                if [ -n "$ven_sec_patch" ]; then
                    if [ -e /sbin/resetprop ]; then
                        resetprop "ro.vendor.build.security_patch" "$ven_sec_patch"
                    else
                        setprop "ro.vendor.build.security_patch" "$ven_sec_patch"
                    fi
                    log_print 1 "已设置 ro.vendor.build.security_patch=$ven_sec_patch"
                    break
                fi
            fi
        done

        # --------------------------------------------------------------
        # 3.2 提取并设置 ro.build.version.release（如果当前为空或假值）
        #     必须在 umount 之前执行，否则无法读取文件
        # --------------------------------------------------------------
        osver=$(get_prop ro.build.version.release)
        if [ -z "$osver" ] || [ "$osver" = "99.87.36" ]; then
            for prop_file in "$VENDOR_MNT/build.prop" "$VENDOR_MNT/etc/build.prop"; do
                if [ -f "$prop_file" ]; then
                    sys_osver=$(grep -m 1 'ro.build.version.release=' "$prop_file" | cut -d'=' -f2-)
                    if [ -n "$sys_osver" ]; then
                        if [ -e /sbin/resetprop ]; then
                            resetprop "ro.build.version.release" "$sys_osver"
                        else
                            setprop "ro.build.version.release" "$sys_osver"
                        fi
                        log_print 1 "已从 vendor 设置 OS 版本: $sys_osver"
                        break
                    fi
                fi
            done
        fi

        # 完成属性提取，卸载 vendor
        umount "$VENDOR_MNT" 2>/dev/null
    fi
fi
# 清理临时挂载点
rmdir "$VENDOR_MNT" 2>/dev/null

# --------------------------------------------------------------
# 4. 检测加密类型（真机为 FBE file）
# --------------------------------------------------------------
encrypt_type=$(get_prop ro.crypto.type)
if [ "$encrypt_type" = "file" ]; then
    log_print 1 "检测到文件级加密 (FBE)，符合 Android 16 预期"
elif [ "$encrypt_type" = "block" ]; then
    log_print 1 "检测到全盘加密 (FDE)，这在 Android 16 上不常见"
else
    log_print 0 "警告: 加密类型未知或未设置，为安全起见假定为 FBE"
    encrypt_type="file"
fi

# 确保 ro.crypto.type 已正确设置（TWRP 依赖此属性）
if [ -e /sbin/resetprop ]; then
    resetprop "ro.crypto.type" "$encrypt_type"
else
    setprop "ro.crypto.type" "$encrypt_type"
fi

# --------------------------------------------------------------
# 5. 等待 TEE 解密链就绪
# --------------------------------------------------------------
log_print 1 "等待 TEE 解密链就绪 (qseecomd -> keymint -> gatekeeper)..."

wait_count=0
max_wait=5  # 5s 快速超时，不阻塞 init 启动

while [ $wait_count -lt $max_wait ]; do
    crypto_ready=$(get_prop crypto.ready)
    listeners_registered=$(get_prop vendor.sys.listeners.registered)
    
    if [ "$crypto_ready" = "1" ] || [ "$listeners_registered" = "true" ]; then
        log_print 1 "解密链就绪 (crypto.ready=$crypto_ready, listeners_registered=$listeners_registered)"
        break
    fi
    
    sleep 1
    wait_count=$((wait_count + 1))
done

if [ $wait_count -ge $max_wait ]; then
    log_print 0 "等待 TEE 解密链超时，将强制继续"
fi

# --------------------------------------------------------------
# 6. 确保 crypto.ready 已设置（兜底保护）
# --------------------------------------------------------------
if [ "$(get_prop crypto.ready)" != "1" ]; then
    if [ -e /sbin/resetprop ]; then
        resetprop "crypto.ready" "1"
    else
        setprop "crypto.ready" "1"
    fi
    log_print 1 "已强制设置 crypto.ready=1 (兜底措施)"
fi

log_print 1 "$SCRIPTNAME 执行完毕。crypto.ready=$(get_prop crypto.ready)"

exit 0