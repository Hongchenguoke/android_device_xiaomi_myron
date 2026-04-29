# =============================================================================
# device.mk
# Device-level package and file declarations for OrangeFox recovery
#
# Device:   Xiaomi Myron (Redmi K90 Pro Max / POCO F8 Ultra)
# Platform: Canoe (Snapdragon 8 Elite Gen 5) / Android 16 / GKI 2.0
#
# NOTE: API levels are set to 34 (Android 14) because OrangeFox fox-14.1
# is built on Android 14 AOSP source tree. Using API 36 causes the
# build system to fail with unrecognized API level errors.
# The device itself runs Android 16, but the recovery build environment
# is Android 14-based.
# =============================================================================

DEVICE_PATH := device/xiaomi/myron

# ===========================================================
# API Level (matches OrangeFox base, not device OS)
# ===========================================================
BOARD_SHIPPING_API_LEVEL   := 34
PRODUCT_SHIPPING_API_LEVEL := 34

# ===========================================================
# Dynamic Partitions (must match BoardConfig.mk)
# ===========================================================
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ===========================================================
# Virtual A/B OTA (enable for VAB devices)
# ===========================================================
PRODUCT_VIRTUAL_AB_OTA := true

# ===========================================================
# A/B Post-Install (required for virtual A/B)
# ===========================================================
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# ===========================================================
# Enforce EROFS support for dynamic partitions
# ===========================================================
PRODUCT_SYSTEM_VERITY_PARTITION := /dev/block/bootdevice/by-name/system
PRODUCT_VENDOR_VERITY_PARTITION := /dev/block/bootdevice/by-name/vendor
PRODUCT_PRODUCT_VERITY_PARTITION := /dev/block/bootdevice/by-name/product
PRODUCT_SYSTEM_EXT_VERITY_PARTITION := /dev/block/bootdevice/by-name/system_ext

# ===========================================================
# OrangeFox / TWRP specific packages
# ===========================================================
PRODUCT_PACKAGES += \
    adbd \
    fastbootd \
    mke2fs \
    e2fsck \
    tune2fs \
    fsck.f2fs \
    mkfs.f2fs \
    fibmap.f2fs \
    fsck.erofs \
    mkfs.erofs \
    lpdump \
    lpmake \
    lpunpack \
    lpflash \
    update_engine_sideload \
    resetprop \
    bash \
    nano \
    strace

# Decryption support (QTI FBE)
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# Optional: battery stats support
ifeq ($(TW_USE_BATTERY_SYSFS_STATS), true)
PRODUCT_PACKAGES += battery healthd
endif

# ===========================================================
# Recovery fstab and init scripts
# ===========================================================
PRODUCT_COPY_FILES += \
    $(DEVICE_PATH)/recovery.fstab:$(TARGET_COPY_OUT_RECOVERY)/root/system/etc/recovery.fstab \
    $(DEVICE_PATH)/init.recovery.qcom.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.qcom.rc \
    $(DEVICE_PATH)/init.recovery.hlthchrg.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.hlthchrg.rc \
    $(DEVICE_PATH)/init.recovery.ldconfig.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.ldconfig.rc \
    $(DEVICE_PATH)/init.recovery.logd.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.logd.rc \
    $(DEVICE_PATH)/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc

# Copy any additional files from recovery/root directory
$(call inherit-product-if-exists, $(DEVICE_PATH)/recovery/root.mk)

# ===========================================================
# Soong namespaces (for device-specific modules)
# ===========================================================
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)

# ===========================================================
# Recovery-specific system properties
# Note: PRODUCT_PROPERTY_OVERRIDES entries are space-separated.
# Values containing spaces will break build.prop generation.
# ===========================================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.board.platform=canoe \
    ro.boot.hardware.platform=canoe \
    ro.hardware=qcom \
    ro.product.device=myron \
    ro.virtual_ab.enabled=true \
    sys.usb.controller=a600000.dwc3 \
    vendor.gatekeeper.disable_spu=true \
    vendor.gatekeeper.is_security_level_spu=0

# ===========================================================
# Set OrangeFox version and maintainer info (optional)
# ===========================================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.orangefox.version=$(FOX_VERSION) \
    ro.orangefox.device=myron \
    ro.orangefox.maintainer=$(OF_MAINTAINER) \
    persist.sys.usb.config=mtp,adb

# ===========================================================
# Include OrangeFox common configuration
# ===========================================================
$(call inherit-product, vendor/orangefox/config/common.mk)
