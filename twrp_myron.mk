# =============================================================================
# twrp_myron.mk
# Top-level product makefile for OrangeFox fox-14.1
#
# Device:   Xiaomi Myron (Redmi K90 Pro Max)
# Platform: Canoe (Snapdragon 8 Elite Gen5) / Android 16 / GKI 2.0
# =============================================================================

# ===========================================================
# Path definition
# ===========================================================
DEVICE_PATH := device/xiaomi/myron

# ===========================================================
# AOSP Product Inheritance (OFox 14.1 verified config)
# ===========================================================

# Pure 64-bit only (device has no 32-bit support)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# Full base system (includes telephony)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# ===========================================================
# Device-specific configuration
# ===========================================================
$(call inherit-product, $(DEVICE_PATH)/device.mk)

# ===========================================================
# Product identification
# ===========================================================
PRODUCT_DEVICE       := myron
PRODUCT_NAME         := twrp_myron
PRODUCT_BRAND        := Redmi
PRODUCT_MODEL        := Redmi K90 Pro Max
PRODUCT_MANUFACTURER := Xiaomi

# ===========================================================
# Build Fingerprint & Description (extracted from device getprop)
# ===========================================================
BUILD_FINGERPRINT := Redmi/myron/myron:16/BP2A.250605.031.A3/OS3.0.305.10.WPMCNXM:user/release-keys

# ===========================================================
# Additional properties (optional, for version identification)
# ===========================================================
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="missi-user 16 BP2A.250605.031.A3 16OS3.1.260417.221736839.QCPECN.S release-keys"
