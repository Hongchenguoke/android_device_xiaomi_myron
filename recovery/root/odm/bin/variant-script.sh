#!/sbin/sh
# ==============================================================================
# myron_variant.sh - Redmi K90 Pro Max (myron) 专属配置
# ==============================================================================

SCRIPT_NAME="myron_variant"
LOG_FILE="/tmp/recovery.log"

log() {
    echo "I:$SCRIPT_NAME: $1" >> "$LOG_FILE"
}

log "开始执行 Myron 机型专属配置..."

# 确定 resetprop 路径
if [ -x /sbin/resetprop ]; then
    RESETPROP="/sbin/resetprop"
elif [ -x /system/bin/resetprop ]; then
    RESETPROP="/system/bin/resetprop"
else
    RESETPROP="setprop"
fi

# --------------------------------------------------------------
# 动态获取真实设备型号（不硬编码）
# --------------------------------------------------------------
MODEL=$(getprop ro.product.model)
if [ -z "$MODEL" ] || [ "$MODEL" = "unknown" ]; then
    # 尝试从 vendor build.prop 读取（如果已挂载）
    if [ -f /v/build.prop ]; then
        MODEL=$(grep -m 1 'ro.product.model=' /v/build.prop | cut -d'=' -f2-)
    fi
    # 最终后备值（与真机信息吻合）
    [ -z "$MODEL" ] && MODEL="Redmi K90 Pro Max"
fi

VARIANT="myron"

log "设备型号: $MODEL"

# 设置产品型号属性
for prop in ro.product.model ro.product.odm.model ro.product.vendor.model \
            ro.product.product.model ro.product.system_ext.model ro.product.system.model; do
    $RESETPROP "$prop" "$MODEL"
done

# 设置产品代号
for prop in ro.build.product ro.product.device ro.product.odm.device \
            ro.product.vendor.device ro.product.product.device \
            ro.product.system_ext.device ro.product.system.device \
            ro.product.bootimage.device ro.product.name ro.product.odm.name \
            ro.product.vendor.name ro.product.product.name \
            ro.product.system_ext.name ro.product.system.name; do
    $RESETPROP "$prop" "$VARIANT"
done

# TWRP 显示偏移（针对红米 K90 Pro Max 屏幕优化）
$RESETPROP ro.twrp.device_version "K90ProMax"
$RESETPROP ro.twrp.y_offset "111"
$RESETPROP ro.twrp.h_offset "-111"

# 显示增强
$RESETPROP vendor.display.enable_spr "1"

# USB 标识
echo "$MODEL" > /config/usb_gadget/g1/strings/0x409/product 2>/dev/null || true
$RESETPROP vendor.usb.product_string "$MODEL"
mkdir -p /usbotg

# 震动参数
$RESETPROP ro.odm.mm.vibrator.audio_haptic_support "true"
$RESETPROP ro.odm.mm.vibrator.resonant_frequency "170"
$RESETPROP ro.odm.mm.vibrator.slide_effect_protect_time "35"
$RESETPROP ro.odm.mm.vibrator.sys_path "/sys/class/qcom-haptics"
$RESETPROP ro.odm.mm.vibrator.device_type "agm"
$RESETPROP ro.vendor.mm.vibrator.sys_path "/sys/class/qcom-haptics"

log "基础属性设置完成"

# --------------------------------------------------------------
# 复制 NXP 库和触屏固件
# --------------------------------------------------------------
VARIANT_SRC="/odm/variant/myron/odm"
if [ -d "$VARIANT_SRC" ]; then
    log "正在从 $VARIANT_SRC 复制专属文件..."
    cp -rf "$VARIANT_SRC/." /odm/
    [ -d /odm/bin ] && chmod -R 755 /odm/bin/ 2>/dev/null || true
    [ -d /odm/lib64 ] && chmod 644 /odm/lib64/*.so 2>/dev/null || true
    [ -d /odm/firmware ] && chmod 644 /odm/firmware/* 2>/dev/null || true
    log "专属文件复制完成"
else
    log "警告: 未找到 $VARIANT_SRC"
fi

$RESETPROP twrp.variant.files_copied "1"
log "Myron 配置完成"
exit 0