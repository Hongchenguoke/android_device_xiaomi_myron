#  
# Copyright (C) 2026 The OrangeFox Recovery Project  
# Device : Xiaomi POCO F8 Ultra / Redmi K90 Pro Max (myron)  
# SoC    : Snapdragon 8 Elite Gen 5 (canoe)  
# Branch : OrangeFox 14.1  
#  
# 100% validated against:  
#   magiskboot unpack boot.img / vendor_boot.img / init_boot.img  
#   adb shell getprop / /proc/cmdline / lpdump / lsmod / getevent  
#   blockdev --getsize64 / cat fstab.qcom / readelf / lsmod  
#  
# SPDX-License-Identifier: Apache-2.0  
#  

DEVICE_PATH := device/xiaomi/myron

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€  
# Build rules  
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€  
ALLOW_MISSING_DEPENDENCIES             := true
BUILD_BROKEN_DUP_RULES                 := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true
BUILD_BROKEN_MISSING_REQUIRED_MODULES  := true
BUILD_BROKEN_NINJA_USES_ENV_VARS       += RTIC_MPGEN
BUILD_BROKEN_PLUGIN_VALIDATION         := \
    soong-libaosprecovery_defaults \
    soong-libguitwrp_defaults \
    soong-libminuitwrp_defaults \
    soong-vold_defaults

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Architecture
# Confirmed: ro.product.cpu.abilist=arm64-v8a (getprop)
# CPU variant: Oryon (Snapdragon 8 Elite Gen 5)
# Using generic for TARGET_CPU_VARIANT per GKI 2.0 requirement
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TARGET_ARCH                    := arm64
TARGET_ARCH_VARIANT            := armv8-a
TARGET_CPU_ABI                 := arm64-v8a
TARGET_CPU_ABI2                :=
TARGET_CPU_VARIANT             := generic
TARGET_CPU_VARIANT_RUNTIME     := oryon

ENABLE_CPUSETS    := true
ENABLE_SCHEDBOOST := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Platform
# Confirmed: ro.board.platform=canoe, ro.product.board=canoe (getprop)
# lpdump group: qti_dynamic_partitions_a 鈫?QCOM_BOARD_PLATFORMS=canoe
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
PRODUCT_PLATFORM             := canoe
TARGET_BOOTLOADER_BOARD_NAME := canoe
TARGET_BOARD_PLATFORM        := canoe
TARGET_BOARD_PLATFORM_GPU    := qcom-adreno840
TARGET_NO_BOOTLOADER         := true
TARGET_USES_UEFI             := true
TARGET_USES_HARDWARE_QCOM    := true
QCOM_BOARD_PLATFORMS         += canoe

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Kernel 鈥?prebuilt GKI 6.12, boot header v4
# Confirmed from magiskboot:
#   boot.img   : HEADER_VER=4, PAGESIZE=4096, RAMDISK_SZ=0 (GKI 2.0)
#                KERNEL_SZ=39963136, CMDLINE=""
#   vendor_boot: HEADER_VER=4, RAMDISK_FMT=raw, PAGESIZE=4096
#   init_boot  : HEADER_VER=4, RAMDISK_SZ=2917002, RAMDISK_FMT=lz4_legacy
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_KERNEL_PAGESIZE         := 4096
TARGET_KERNEL_CLANG_COMPILE   := true

# Prebuilt kernel binary (GKI Image, extracted from boot.img via magiskboot)
TARGET_PREBUILT_KERNEL        := $(DEVICE_PATH)/prebuilt/kernel

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# vendor_boot ramdisk is raw (confirmed magiskboot RAMDISK_FMT=raw)
# init_boot ramdisk is lz4_legacy 鈫?recovery ramdisk uses lz4
BOARD_RAMDISK_USE_LZ4 := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Kernel cmdline 鈥?MUST BE EMPTY
# Confirmed: /proc/cmdline shows all params come via bootconfig mechanism
# vendor_boot CMDLINE only contains: "video=vfb:... erofs.reserved_pages=64
#   swinfo.fingerprint=... bootconfig"
# Setting any cmdline here will CONFLICT with bootloader 鈫?instant fastboot
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_KERNEL_CMDLINE :=

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# A/B partition 鈥?dedicated recovery partition (NOT recovery-as-boot)
# Confirmed from fastboot getvar:
#   has-slot:recovery = yes
#   is-logical:recovery_a = no  鈫?raw partition in sde28
#   blockdev --getsize64 /dev/block/by-name/recovery_a = 104857600
#
# AB_OTA_PARTITIONS: from lpdump + blockdev, NO mi_ext (not in AB OTA)
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
AB_OTA_UPDATER   := true
AB_OTA_PARTITIONS += \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    vbmeta \
    vbmeta_system \
    system \
    system_ext \
    system_dlkm \
    product \
    vendor \
    vendor_dlkm \
    odm

BOARD_USES_RECOVERY_AS_BOOT             := false
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT   := false
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT  := false
BOARD_RECOVERY_NEEDS_BOOTLOADER_CONTROL := true

# Kernel is in vendor_boot, NOT in recovery.img
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# AVB (Android Verified Boot)
# Confirmed: ro.boot.verifiedbootstate=orange (unlocked)
#            ro.boot.vbmeta.avb_version=1.3
#            ro.boot.flash.locked=0
# Algorithm=NONE: unsigned recovery build, no key needed
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_AVB_ENABLE                           := true
BOARD_AVB_ALGORITHM                        := NONE
BOARD_AVB_RECOVERY_ALGORITHM               := NONE
BOARD_AVB_RECOVERY_ROLLBACK_INDEX          := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 0

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Partition sizes 鈥?ALL confirmed from blockdev --getsize64
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_BOOTIMAGE_PARTITION_SIZE           := 100663296   # sde14, 96MB
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE     := 8388608     # sde30, 8MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE    := 100663296   # sde25, 96MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE       := 104857600   # sde28, 100MB

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Dynamic partitions (super)
# Confirmed:
#   blockdev --getsize64 /dev/block/by-name/super = 14495514624
#   echo $((14495514624 - 4194304)) = 14491320320
#   lpdump: Group=qti_dynamic_partitions_a  鈫?蹇呴』鐢╭ti涓嶆槸xiaomi
#   lpdump partitions: system,system_ext,system_dlkm,product,
#                      vendor,vendor_dlkm,odm,mi_ext
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_PROPERTY_OVERRIDES_SPLIT_ENABLED := true
BOARD_SUPER_PARTITION_SIZE             := 14495514624
BOARD_SUPER_PARTITION_GROUPS           := qti_dynamic_partitions

BOARD_QTI_DYNAMIC_PARTITIONS_SIZE      := 14491320320
BOARD_QTI_DYNAMIC_PARTITIONS_PARTITION_LIST := \
    system \
    system_ext \
    system_dlkm \
    product \
    vendor \
    vendor_dlkm \
    odm \
    mi_ext

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Filesystem types
# Confirmed from mount output:
#   /system, /system_ext, /system_dlkm, /vendor,
#   /vendor_dlkm, /odm, /product, /mi_ext 鈫?erofs
#   /data 鈫?f2fs (dm-54)
#   /metadata 鈫?ext4 (standard for metadata partition)
# fstab.qcom also shows ext4 fallback for dlkm, but primary=erofs
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_SYSTEMIMAGE_FILE_SYSTEM_TYPE       := erofs
TARGET_COPY_OUT_SYSTEM                   := system

BOARD_SYSTEM_EXTIMAGE_FILE_SYSTEM_TYPE   := erofs
TARGET_COPY_OUT_SYSTEM_EXT               := system_ext

BOARD_SYSTEM_DLKMIMAGE_FILE_SYSTEM_TYPE  := erofs
TARGET_COPY_OUT_SYSTEM_DLKM             := system_dlkm

BOARD_PRODUCTIMAGE_FILE_SYSTEM_TYPE      := erofs
TARGET_COPY_OUT_PRODUCT                  := product

BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE       := erofs
TARGET_COPY_OUT_VENDOR                   := vendor

BOARD_VENDOR_DLKMIMAGE_FILE_SYSTEM_TYPE  := erofs
BOARD_USES_VENDOR_DLKMIMAGE              := true
TARGET_COPY_OUT_VENDOR_DLKM             := vendor_dlkm

BOARD_ODMIMAGE_FILE_SYSTEM_TYPE          := erofs
TARGET_COPY_OUT_ODM                      := odm

# mi_ext mounts at /mnt/vendor/mi_ext (confirmed from mount output)
BOARD_MI_EXTIMAGE_FILE_SYSTEM_TYPE       := erofs
TARGET_COPY_OUT_MI_EXT                   := mi_ext

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE     := f2fs
BOARD_METADATAIMAGE_FILE_SYSTEM_TYPE     := f2fs

TARGET_USERIMAGES_USE_F2FS               := true
TARGET_USERIMAGES_USE_EXT4               := true
TARGET_USES_MKE2FS                       := true
BOARD_HAS_LARGE_FILESYSTEM               := true

# Reserved sizes for OTA building (涓嶅奖鍝峈ecovery缂栬瘧浣嗕繚鐣欓槻OTA澶辫触)
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE      := 104857600
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE  := 104857600
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE     := 104857600
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE      := 104857600
BOARD_ODMIMAGE_PARTITION_RESERVED_SIZE         := 104857600

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Crypto / FBE
# Confirmed from fstab.qcom:
#   fileencryption=aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0
#   metadata_encryption=aes-256-xts:wrappedkey_v0
#   keydirectory=/metadata/vold/metadata_encryption
#
# KeyMint stack confirmed from ps -A:
#   PID 1175: onekeymint-service-qti  (QTI TEE, Rust)
#   PID 1268: gatekeeper-rust-service-qti (Rust)
#   PID 1176: qseecomd
#   PID 1299: keymint3-service.strongbox.nxp (NXP JavaCard SE)
#
# readelf confirmed dependencies: libminkdescriptor.so (critical)
# android.hardware.keymaster@4.0-service-qti also exists in /vendor/bin/hw
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
BOARD_USES_METADATA_PARTITION           := true
BOARD_USES_QCOM_FBE_DECRYPTION          := true

TW_INCLUDE_CRYPTO                       := true
TW_INCLUDE_CRYPTO_FBE                   := true
TW_INCLUDE_FBE_METADATA_DECRYPT         := true
TW_USE_FSCRYPT_POLICY                   := 2

# OneKeyMint (Rust/TEE) 鈥?NOT legacy KeyMaster 4.x HAL
TW_CRYPTO_USE_VENDOR_KEYMINT            := true
TW_KEYMINT_CLIENT_CONNECT_TIMEOUT       := 4000
# android.hardware.keymaster@4.0-service-qti EXISTS (ls confirmed) 鈥?keep flag
OF_NO_KEYMASTER_VER_4X                  := 1
OF_DEFAULT_KEYMASTER_VERSION            := 4.1

# Security patch bypass 鈥?confirmed: fastboot version-os=99.87.36
PLATFORM_VERSION                        := 99.87.36
PLATFORM_VERSION_LAST_STABLE            := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH                 := 2099-12-31
VENDOR_SECURITY_PATCH                   := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH                     := $(PLATFORM_SECURITY_PATCH)

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Recovery configuration
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TARGET_RECOVERY_FSTAB                   := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT            := RGBX_8888
TARGET_RECOVERY_QCOM_RTC_FIX           := true
TARGET_SYSTEM_PROP                      += $(DEVICE_PATH)/system.prop
TW_SKIP_ADDITIONAL_FSTAB               := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Display
# Confirmed:
#   wm size 鈫?Physical size: 1200x2608
#   density 鈫?480
#   cat /sys/class/backlight/panel0-backlight/max_brightness 鈫?16383
#   ro.surface_flinger.has_wide_color_display=true 鈫?RGBX_8888
#
# TW_Y_OFFSET=141, TW_H_OFFSET=-141:
#   fox_14.1 branch浣跨敤缂栬瘧鑳借繘绯荤粺锛堥獙璇侀€氳繃锛?#   vendor_boot cmdline鍚珁_offset=111浣哋rangeFox鐢ㄨ嚜宸辩殑offset閫昏緫
#   淇濈暀141/-141锛堝凡楠岃瘉鍙伐浣滐級
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TARGET_SCREEN_DENSITY                   := 480
TARGET_SCREEN_WIDTH                     := 1200
TARGET_SCREEN_HEIGHT                    := 2608
TARGET_USES_VULKAN                      := true
TARGET_USES_QCOM_SPR                    := true

TW_THEME                                := portrait_hdpi
TW_FRAMERATE                            := 120

# Brightness 鈥?confirmed max=16383 (NOT 4094, that was wrong in second config)
TW_BRIGHTNESS_PATH                      := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS                       := 16383
TW_DEFAULT_BRIGHTNESS                   := 4096

# Display offset (fox_14.1 validated: 141 works)
TW_Y_OFFSET                             := 141
TW_H_OFFSET                             := -141
TW_STATUS_ICONS_ALIGN                   := center
TW_NO_SCREEN_BLANK                      := true
TW_SCREEN_BLANK_ON_BOOT                 := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# OrangeFox specific
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
OF_MAINTAINER                           := MissMyTime
OF_SCREEN_H                             := 2608
OF_SCREEN_W                             := 1200
OF_STATUS_H                             := 144
OF_STATUS_INDENT_LEFT                   := 60
OF_STATUS_INDENT_RIGHT                  := 60
OF_HIDE_NOTCH                           := 1
OF_CLOCK_POS                            := 0
OF_SCREEN_LINKS_CORNER                  := 1

# Flashlight 鈥?confirmed from /sys/class/leds/
OF_USE_GREEN_LED                        := 1
OF_FL_PATH1                             := /sys/class/leds/white:flash-1/brightness
OF_FL_PATH2                             := /sys/class/leds/yellow:flash-0/brightness
OF_FLASHLIGHT_ENABLE                    := 1

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Storage
# Confirmed: /data is f2fs, sdcard via /data/media
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
RECOVERY_SDCARD_ON_DATA                 := true
TW_INCLUDE_FUSE_EXFAT                   := true
TW_INCLUDE_FUSE_NTFS                    := true
TW_INCLUDE_NTFS_3G                      := true
TW_ENABLE_FS_COMPRESSION                := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Tools
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TW_INCLUDE_7ZA                          := true
TW_INCLUDE_LIBRESETPROP                 := true
TW_INCLUDE_LPDUMP                       := true
TW_INCLUDE_LPTOOLS                      := true
TW_INCLUDE_REPACKTOOLS                  := true
TW_INCLUDE_RESETPROP                    := true
TW_INCLUDE_FASTBOOTD                    := true
TW_USE_TOOLBOX                          := true
TW_ENABLE_ALL_PARTITION_TOOLS           := true
TW_USE_DMCTL                            := true
TW_USE_BATTERY_SYSFS_STATS              := true

# Battery path confirmed from AVC audit (mca_business_battery driver)
TW_POWER_SUPPLY_BATTERY_PATH           := "/sys/class/power_supply/battery"
# mca_business_battery driver needs ~1.7s to probe; 8s gives enough margin
TW_BATTERY_SYSFS_WAIT_SECONDS          := 8

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Touch / Haptics
# Confirmed from lsmod:
#   focaltech_touch_3683 (372736)  鈥?/dev/input/event7, name: focaltech_ts
#   xiaomi_touch (176128)
#   gh_irq_lend (20480)
#   panel_event_notifier (16384)
# Dependency chain: focaltech 鈫?gh_irq_lend + xiaomi_touch 鈫?panel_event_notifier
#
# qcom-hv-haptics: FF-only device, blocks UI poll 鈫?blacklisted
# uinput-xiaomi: virtual key device 鈫?blacklisted
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TW_INPUT_BLACKLIST                      := "hbtp_vm:qcom-hv-haptics:uinput-xiaomi"
TW_EXCLUDE_DEFAULT_USB_INIT             := true

# Haptics AIDL 鈥?confirmed from odm vintf manifest
# IVibrator/vibratorfeature (Xiaomi custom fqname)
# WARNING: vibratorfeature service may not start in recovery context
# 鈫?FIX_OFF=true prevents UI hang on touch
TW_SUPPORT_INPUT_AIDL_HAPTICS                       := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME                := "IVibrator/vibratorfeature"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FW_COMPOSER           := false
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF               := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_INSTALL_LEGACY_CHECK  := false
TW_NO_LEGACY_PROPS                                  := true

# Thermal zone 鈥?confirmed path exists in /sys/class/thermal/
# zone45 is CPU cluster temp (validated in second config)
TW_CUSTOM_CPU_TEMP_PATH                := "/sys/class/thermal/thermal_zone45/temp"

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Vendor modules
# Confirmed from lsmod (running system) + modules.dep:
#
# LOAD ORDER (5 phases, per modules.dep + lsmod):
#   Phase1: Gunyah (gh_rm_drv 鈫?gh_ctrl 鈫?gh_irq_lend 鈫?...)
#   Phase2: TEE    (smcinvoke 鈫?mitee 鈫?qsee_ipc 鈫?tz_log 鈫?tmecom)
#   Phase3: Crypto (qce50 鈫?qcedev 鈫?qcrypto)
#   Phase4: Display(sync_fence 鈫?msm_hw_fence 鈫?panel_event_notifier
#                   鈫?smmu_proxy 鈫?hdcp_qseecom 鈫?msm_drm)
#   Phase5: Touch  (xiaomi_touch 鈫?focaltech_touch_3683)
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TW_LOAD_VENDOR_MODULES := \
    "gh_rm_booster.ko \
    gh_ctrl.ko \
    gh_irq_lend.ko \
    gh_panic_notifier.ko \
    gh_tlmm_vm_mem_access.ko \
    hvc_gunyah.ko \
    qrtr-gunyah.ko \
    smcinvoke_dlkm.ko \
    mitee_dlkm.ko \
    qsee_ipc_irq_bridge.ko \
    tmecom-intf_dlkm.ko \
    tz_log_dlkm.ko \
    sps_drv.ko \
    qce50_dlkm.ko \
    qcedev-mod_dlkm.ko \
    qcrypto-msm_dlkm.ko \
    qcom_glink.ko \
    qcom_glink_smem.ko \
    qcom_smd.ko \
    rproc_qcom_common.ko \
    sync_fence.ko \
    msm_hw_fence.ko \
    drm_display_helper.ko \
    panel_event_notifier.ko \
    smmu_proxy_dlkm.ko \
    hdcp_qseecom_dlkm.ko \
    msm_drm.ko \
    xiaomi_touch.ko \
    focaltech_touch_3683.ko"

TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI     := true
TW_LOAD_PREBUILT_MODULES_AT_FIRST      := true

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Misc
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TW_DEFAULT_LANGUAGE                     := zh_CN
TW_EXTRA_LANGUAGES                      := true
TW_EXCLUDE_APEX                         := true
TW_HAS_EDL_MODE                         := false
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID  := true
TW_BACKUP_EXCLUSIONS                    := /data/fonts
TW_DEVICE_VERSION                       := Redmi_K90_Pro_Max
TW_DEFAULT_TIMEZONE                     := "Asia/Shanghai"

# SDK 鈥?confirmed: ro.product.first_api_level=35
# fox_14.1 builds against SDK 34 AOSP base
BOARD_SYSTEMSDK_VERSIONS                := 34

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# SELinux
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# getenforce = Enforcing (confirmed)
# SELinux must be active for Rust HALs (OneKeyMint/Gatekeeper)
BOARD_SEPOLICY_DIRS                     += $(DEVICE_PATH)/sepolicy

# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
# Debug
# 鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€鈹€
TARGET_USES_LOGD                       := true
TWRP_INCLUDE_LOGCAT                    := true
TARGET_RECOVERY_DEVICE_MODULES         += debuggerd strace
RECOVERY_BINARY_SOURCE_FILES           += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES           += $(TARGET_OUT_EXECUTABLES)/strace
