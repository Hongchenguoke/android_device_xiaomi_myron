#!/system/bin/sh
# =============================================================================
# postrecoveryboot.sh
# 运行于 TWRP/Fox 启动初期，用于加载超大体积的外部驱动
# =============================================================================

# 1. 给动态分区的映射留一点时间
sleep 2

# 2. 临时挂载 vendor_dlkm 逻辑分区 (erofs 格式，只读)
mkdir -p /vendor_dlkm_temp
mount -t erofs -o ro /dev/block/mapper/vendor_dlkm /vendor_dlkm_temp

# 3. 检查并按严格链式依赖加载 WiFi 模块
if [ -f /vendor_dlkm_temp/lib/modules/qca_cld3_peach_v2.ko ]; then
    echo "I: [WiFi] Found driver, loading modules..." > /dev/kmsg
    
    # 必须按顺序：cnss2 → icnss2 → qca_cld3
    insmod /vendor_dlkm_temp/lib/modules/cnss2.ko
    insmod /vendor_dlkm_temp/lib/modules/icnss2.ko
    insmod /vendor_dlkm_temp/lib/modules/qca_cld3_peach_v2.ko

    # 伪造固件符号链接以防底层找不到
    mkdir -p /vendor/firmware/wlan/qca_cld
    ln -s /vendor_dlkm_temp/firmware /vendor/firmware/wlan/qca_cld/peach_v2

    # 通知系统网卡已就绪
    setprop wifi.modules.loaded 1
    echo "I: [WiFi] Modules loaded successfully" > /dev/kmsg
else
    echo "E: [WiFi] Driver not found in vendor_dlkm!" > /dev/kmsg
fi

# 4. 卸载临时分区，释放占用，保证用户后续可以正常双清或刷机
umount /vendor_dlkm_temp
rmdir /vendor_dlkm_temp

exit 0