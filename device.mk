# =============================================================================  
# device.mk  
# Device-level package and file declarations for OrangeFox recovery  
#  
# Device:   Xiaomi Myron (Redmi K90 Pro Max)  
# Platform: Canoe (Snapdragon 8 Elite) / Android 16 / GKI 2.0  
#  
# NOTE: API levels are set to 34 (Android 14) because OrangeFox fox-14.1  
# is built on Android 14 AOSP source tree. Using API 36 causes the  
# build system to fail with unrecognized API level errors.  
# The device itself runs Android 16, but the recovery build environment  
# is Android 14-based.  
# =============================================================================  
DEVICE_PATH := device/xiaomi/myron

# ===========================================================  
# API Level  
# Must match OrangeFox build base (Android 14), NOT device OS  
# ===========================================================  
BOARD_SHIPPING_API_LEVEL   := 34
PRODUCT_SHIPPING_API_LEVEL := 34

# ===========================================================  
# Dynamic Partitions  
# ===========================================================  
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ===========================================================  
# Virtual A/B OTA  
# ===========================================================  
PRODUCT_VIRTUAL_AB_OTA := true

PRODUCT_PACKAGES += \
    lpflash \
    lpmake \
    lpunpack \
    update_engine_sideload

# ===========================================================  
# A/B Post-Install  
# ===========================================================  
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=erofs \
    POSTINSTALL_OPTIONAL_system=true

# ===========================================================  
# Qualcomm FBE Decryption  
# ===========================================================  
PRODUCT_PACKAGES += \
    qcom_decrypt \
    qcom_decrypt_fbe

# ===========================================================  
# Fastbootd  
# ===========================================================  
PRODUCT_PACKAGES += \
    fastbootd

# ===========================================================  
# Recovery-Specific Properties  
#  
# CRITICAL: PRODUCT_PROPERTY_OVERRIDES is SPACE-SEPARATED.  
# Values containing spaces break the build.prop shell generator.  
#  
# DO NOT set here:  
#   ro.product.brand        → auto from PRODUCT_BRAND in twrp_myron.mk  
#   ro.product.model        → auto from PRODUCT_MODEL in twrp_myron.mk  
#   ro.product.manufacturer → auto from PRODUCT_MANUFACTURER in twrp_myron.mk  
# ===========================================================  
PRODUCT_PROPERTY_OVERRIDES += \
    ro.hardware=qcom \
    ro.board.platform=canoe \
    ro.boot.hardware.platform=canoe \
    ro.product.device=myron \
    ro.virtual_ab.enabled=true \
    ro.hardware.keystore= \
    sys.usb.controller=a600000.dwc3 \
    vendor.gatekeeper.disable_spu=true \
    vendor.gatekeeper.is_security_level_spu=0

# ===========================================================  
# Soong Namespaces  
# ===========================================================  
PRODUCT_SOONG_NAMESPACES += \
    $(DEVICE_PATH)
