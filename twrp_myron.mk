# =============================================================================
# twrp_myron.mk
# Top-level product makefile for OrangeFox fox-14.1
#
# Device:   Xiaomi Myron (Redmi K90 Pro Max / POCO F8 Ultra)
# Platform: Canoe (Snapdragon 8 Elite) / Android 16 / GKI 2.0
# =============================================================================

# ===========================================================
# 路径定义
# ===========================================================
DEVICE_PATH := device/xiaomi/myron

# ===========================================================
# AOSP Product Inheritance (OFox 14.1 验证配置)
# ===========================================================

# 64位基础
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)

# 完整基础系统 
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# ===========================================================
# 设备专属配置
# ===========================================================
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# ===========================================================
# 产品标识
# ===========================================================
PRODUCT_DEVICE       := myron
PRODUCT_NAME         := twrp_myron
PRODUCT_BRAND        := Xiaomi
PRODUCT_MODEL        := Redmi K90 Pro Max
PRODUCT_MANUFACTURER := Xiaomi

# ===========================================================
# Build Fingerprint
# 用于 OTA 兼容性验证
# ===========================================================
BUILD_FINGERPRINT := Xiaomi/myron/myron:16/OS3.0.23.0.WPMCNXM/OS3.0.23.0.WPMCNXM:user/release-keys

# ===========================================================
# 附加属性（可选，用于版本识别）
# ===========================================================
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="myron-user 16 OS3.0.23.0.WPMCNXM OS3.0.23.0.WPMCNXM release-keys"
