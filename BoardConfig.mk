# ==============================================================================
# BoardConfig.mk — Redmi K90 Pro Max (myron)
#
# SoC    : Snapdragon 8 Elite Gen 5 (canoe / sm8850)
# Android: 16 (API 36) · GKI 2.0 · boot header v4
# Branch : OrangeFox 14.1 (fox_14.1)
# Author : MissMyTime 
# Date   : 2026-04-29
#
# This file is heavily commented to serve as a reference for future ports.
# All values are cross-checked against live device dumps (getprop, magiskboot,
# lpdump, blockdev --getsize64, lsmod, getevent, etc.).
#
# ==============================================================================

# ------------------------------------------------------------------------------
# 0. Build system workarounds (必需的兼容性标志)
#    These are needed because recovery builds in a limited source tree.
# ------------------------------------------------------------------------------
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

DEVICE_PATH := device/xiaomi/myron   

# ------------------------------------------------------------------------------
# 1. Architecture (64‑bit only)
#    Snapdragon 8 Elite Gen 5 已移除 32 位支持，请勿添加 TARGET_2ND_ARCH。
# ------------------------------------------------------------------------------
TARGET_ARCH                    := arm64
TARGET_ARCH_VARIANT            := armv8-a
TARGET_CPU_ABI                 := arm64-v8a
TARGET_CPU_ABI2                :=
TARGET_CPU_VARIANT             := generic      # GKI 2.0 要求
TARGET_CPU_VARIANT_RUNTIME     := oryon        # Oryon core (Kryo 替换)

ENABLE_CPUSETS    := true
ENABLE_SCHEDBOOST := true

# ------------------------------------------------------------------------------
# 2. Platform identification
#    Confirmed: ro.board.platform=canoe, ro.product.board=canoe
#               lpdump group: qti_dynamic_partitions_a
# ------------------------------------------------------------------------------
PRODUCT_PLATFORM             := canoe
TARGET_BOOTLOADER_BOARD_NAME := canoe
TARGET_BOARD_PLATFORM        := canoe
TARGET_BOARD_PLATFORM_GPU    := qcom-adreno840
TARGET_NO_BOOTLOADER         := true
TARGET_USES_UEFI             := true
TARGET_USES_HARDWARE_QCOM    := true
QCOM_BOARD_PLATFORMS         += canoe

# ------------------------------------------------------------------------------
# 3. Kernel & boot header
#    boot.img          : HEADER_VER=4, RAMDISK_SZ=0 (GKI 2.0)
#    recovery.img      : HEADER_VER=4, RAMDISK_SZ=28386861
#    vendor_boot.img   : HEADER_VER=4, RAMDISK_FMT=raw
#    init_boot.img     : HEADER_VER=4, RAMDISK_FMT=lz4_legacy
#
#    Recovery 镜像本身不带内核，内核由 bootloader 从 boot 分区加载。
#    为防止 fox_14.1 构建系统报错，提供一个占位内核文件，但强制排除打包。
# ------------------------------------------------------------------------------
TARGET_KERNEL_ARCH            := arm64
TARGET_KERNEL_HEADER_ARCH     := arm64
BOARD_KERNEL_IMAGE_NAME       := Image
BOARD_BOOT_HEADER_VERSION     := 4
BOARD_KERNEL_PAGESIZE         := 4096

# 占位预编译内核 (取 boot.img 中的 Image 复制而来，构建时需要存在，但不入包)
TARGET_PREBUILT_KERNEL        := $(DEVICE_PATH)/prebuilt/kernel
BOARD_EXCLUDE_KERNEL_FROM_RECOVERY_IMAGE := true

BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOT_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --pagesize $(BOARD_KERNEL_PAGESIZE)

# 使用 LZ4 压缩 ramdisk (与 init_boot 的 lz4_legacy 兼容)
BOARD_RAMDISK_USE_LZ4 := true

# kernel cmdline 必须为空 (所有参数已通过 bootconfig 传入)
BOARD_KERNEL_CMDLINE :=

# ------------------------------------------------------------------------------
# 4. A/B partition layout — dedicated recovery
#    has-slot:recovery = yes
#    is-logical:recovery_a = no (raw sde28)
# ------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
# 5. AVB — unlocked device, unsigned recovery build
#    ro.boot.verifiedbootstate=orange
#    Algorithm=NONE does not require any keys.
# ------------------------------------------------------------------------------
BOARD_AVB_ENABLE                           := true
BOARD_AVB_ALGORITHM                        := NONE
BOARD_AVB_RECOVERY_ALGORITHM               := NONE
BOARD_AVB_RECOVERY_ROLLBACK_INDEX          := 0
BOARD_AVB_RECOVERY_ROLLBACK_INDEX_LOCATION := 0

# ------------------------------------------------------------------------------
# 6. Partition sizes — every value is confirmed by blockdev --getsize64
# ------------------------------------------------------------------------------
BOARD_BOOTIMAGE_PARTITION_SIZE           := 100663296   # 96 MB
BOARD_INIT_BOOT_IMAGE_PARTITION_SIZE     := 8388608     # 8 MB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE    := 100663296   # 96 MB
BOARD_RECOVERYIMAGE_PARTITION_SIZE       := 104857600   # 100 MB

# ------------------------------------------------------------------------------
# 7. Dynamic partitions (super)
#    super size: 14495514624 (blockdev)
#    Group name: qti_dynamic_partitions (lpdump)
#    Max group size: 14485028864; here we use a bit less (14491320320)
#    Partition list: system, system_ext, system_dlkm, product,
#                    vendor, vendor_dlkm, odm, mi_ext
# ------------------------------------------------------------------------------
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

# ------------------------------------------------------------------------------
# 8. Filesystem types
#    All read‑only images use EROFS (confirmed by mount output).
#    /data → f2fs; /metadata → ext4.
# ------------------------------------------------------------------------------
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

# mi_ext 挂载在 /mnt/vendor/mi_ext
BOARD_MI_EXTIMAGE_FILE_SYSTEM_TYPE       := erofs
TARGET_COPY_OUT_MI_EXT                   := mi_ext

BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE     := f2fs
BOARD_METADATAIMAGE_FILE_SYSTEM_TYPE     := ext4

TARGET_USERIMAGES_USE_F2FS               := true
TARGET_USERIMAGES_USE_EXT4               := true
TARGET_USES_MKE2FS                       := true
BOARD_HAS_LARGE_FILESYSTEM               := true

# OTA reserved sizes (不影响 recovery 但保留以保持完整)
BOARD_SYSTEMIMAGE_PARTITION_RESERVED_SIZE      := 104857600
BOARD_SYSTEM_EXTIMAGE_PARTITION_RESERVED_SIZE  := 104857600
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE     := 104857600
BOARD_VENDORIMAGE_PARTITION_RESERVED_SIZE      := 104857600
BOARD_ODMIMAGE_PARTITION_RESERVED_SIZE         := 104857600

# ------------------------------------------------------------------------------
# 9. Encryption (FBE v2) — fstab.qcom based
#    fileencryption= aes-256-xts:aes-256-cts:v2+inlinecrypt_optimized+wrappedkey_v0
#    metadata_encryption= aes-256-xts:wrappedkey_v0
#
#    KeyMint stack:
#      onekeymint-service-qti  (Rust, QTI TEE)
#      keymint3-service.strongbox.nxp (NXP JavaCard)
#    Enable vendor keymint support; avoid keymaster 4.x fallback.
# ------------------------------------------------------------------------------
BOARD_USES_METADATA_PARTITION           := true
BOARD_USES_QCOM_FBE_DECRYPTION          := true

TW_INCLUDE_CRYPTO                       := true
TW_INCLUDE_CRYPTO_FBE                   := true
TW_INCLUDE_FBE_METADATA_DECRYPT         := true
TW_USE_FSCRYPT_POLICY                   := 2

# Primary decryption via OneKeyMint (Rust/TEE)
TW_CRYPTO_USE_VENDOR_KEYMINT            := true
TW_KEYMINT_CLIENT_CONNECT_TIMEOUT       := 4000

# Security patch bypass (device reports os=99.87.36, patch=2099‑12‑31)
PLATFORM_VERSION                        := 99.87.36
PLATFORM_VERSION_LAST_STABLE            := $(PLATFORM_VERSION)
PLATFORM_SECURITY_PATCH                 := 2099-12-31
VENDOR_SECURITY_PATCH                   := $(PLATFORM_SECURITY_PATCH)
BOOT_SECURITY_PATCH                     := $(PLATFORM_SECURITY_PATCH)

# ------------------------------------------------------------------------------
# 10. Recovery configuration
# ------------------------------------------------------------------------------
TARGET_RECOVERY_FSTAB                   := $(DEVICE_PATH)/recovery.fstab
TARGET_RECOVERY_PIXEL_FORMAT            := RGBX_8888
TARGET_RECOVERY_QCOM_RTC_FIX            := true
TARGET_SYSTEM_PROP                      += $(DEVICE_PATH)/system.prop
TW_SKIP_ADDITIONAL_FSTAB                := true       # 仅使用 recovery 自己的 fstab

# ------------------------------------------------------------------------------
# 11. Display
#     wm size → 1200×2608, density 480
#     max brightness → 16383
#     fox_14.1 offsets validated: TW_Y_OFFSET=111, TW_H_OFFSET=-111
# ------------------------------------------------------------------------------
TARGET_SCREEN_DENSITY                   := 480
TARGET_SCREEN_WIDTH                     := 1200
TARGET_SCREEN_HEIGHT                    := 2608
TARGET_USES_VULKAN                      := true
TARGET_USES_QCOM_SPR                    := true

TW_THEME                                := portrait_hdpi
TW_FRAMERATE                            := 120

TW_BRIGHTNESS_PATH                      := "/sys/class/backlight/panel0-backlight/brightness"
TW_MAX_BRIGHTNESS                       := 16383
TW_DEFAULT_BRIGHTNESS                   := 4096

TW_Y_OFFSET                             := 111
TW_H_OFFSET                             := -111
TW_STATUS_ICONS_ALIGN                   := center
TW_NO_SCREEN_BLANK                      := true

# ------------------------------------------------------------------------------
# 12. OrangeFox‑specific UI & features
#     OF_SCREEN_H should equal native screen height for 1:1 mapping.
# ------------------------------------------------------------------------------
OF_MAINTAINER                           := MissMyTime
OF_SCREEN_H                             := 2608
OF_SCREEN_W                             := 1200
OF_STATUS_H                             := 144
OF_STATUS_INDENT_LEFT                   := 60
OF_STATUS_INDENT_RIGHT                  := 60
OF_HIDE_NOTCH                           := 1
OF_CLOCK_POS                            := 0
OF_SCREEN_LINKS_CORNER                  := 1

# Flashlight
OF_USE_GREEN_LED                        := 1
OF_FL_PATH1                             := /sys/class/leds/white:flash-1/brightness
OF_FL_PATH2                             := /sys/class/leds/yellow:flash-0/brightness
OF_FLASHLIGHT_ENABLE                    := 1

# ------------------------------------------------------------------------------
# 13. Storage & filesystem tools
# ------------------------------------------------------------------------------
RECOVERY_SDCARD_ON_DATA                 := true
TW_INCLUDE_FUSE_EXFAT                   := true
TW_INCLUDE_FUSE_NTFS                    := true
TW_INCLUDE_NTFS_3G                      := true
TW_ENABLE_FS_COMPRESSION                := true

# ------------------------------------------------------------------------------
# 14. Tools and extras
# ------------------------------------------------------------------------------
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

# Battery info
TW_POWER_SUPPLY_BATTERY_PATH           := "/sys/class/power_supply/battery"
TW_BATTERY_SYSFS_WAIT_SECONDS          := 8   # mca_business_battery 驱动需要 >1.7s

# ------------------------------------------------------------------------------
# 15. Touch / Input
#     focaltech_ts (event7) ; load order: panel_event_notifier → xiaomi_touch → focaltech
#     Blacklist haptics & virtual keys to avoid UI polling.
# ------------------------------------------------------------------------------
TW_INPUT_BLACKLIST                      := "hbtp_vm:qcom-hv-haptics:uinput-xiaomi"
TW_EXCLUDE_DEFAULT_USB_INIT             := true

# Haptics AIDL (vibratorfeature) — may fail; FIX_OFF prevents hang
TW_SUPPORT_INPUT_AIDL_HAPTICS                       := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME                := "IVibrator/vibratorfeature"
TW_SUPPORT_INPUT_AIDL_HAPTICS_FW_COMPOSER           := false
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF               := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_INSTALL_LEGACY_CHECK  := false
TW_NO_LEGACY_PROPS                                  := true

# CPU temperature
TW_CUSTOM_CPU_TEMP_PATH                := "/sys/class/thermal/thermal_zone45/temp"

# ------------------------------------------------------------------------------
# 16. Vendor modules loading
# Only touch-related modules are manually listed; display and others are auto-loaded.
# Dependency order verified via live TWRP lsmod/dmesg.
# ------------------------------------------------------------------------------
TW_LOAD_VENDOR_MODULES := \
    rproc_qcom_common \
    smcinvoke_dlkm \
    gh_rm_drv \
    gh_irq_lend \
    panel_event_notifier \
    xiaomi_touch \
    focaltech_touch_3683
TW_LOAD_VENDOR_MODULES_EXCLUDE_GKI     := true
TW_LOAD_PREBUILT_MODULES_AT_FIRST      := true

# ------------------------------------------------------------------------------
# 17. General recovery preferences
# ------------------------------------------------------------------------------
TW_DEFAULT_LANGUAGE                     := zh_CN
TW_EXTRA_LANGUAGES                      := true
TW_EXCLUDE_APEX                         := true
TW_HAS_EDL_MODE                         := false
TW_USE_SERIALNO_PROPERTY_FOR_DEVICE_ID  := true
TW_BACKUP_EXCLUSIONS                    := /data/fonts
TW_DEVICE_VERSION                       := Redmi_K90_Pro_Max
TW_DEFAULT_TIMEZONE                     := "Asia/Shanghai"

# SDK targeting
BOARD_SYSTEMSDK_VERSIONS                := 34

# SELinux (keep enforcing; Rust HALs require it)
# BOARD_SEPOLICY_DIRS not set → using AOSP default sepolicy

# Debug tools (optional)
TARGET_USES_LOGD                       := true
TWRP_INCLUDE_LOGCAT                    := true
TARGET_RECOVERY_DEVICE_MODULES         += debuggerd strace
RECOVERY_BINARY_SOURCE_FILES           += $(TARGET_OUT_EXECUTABLES)/debuggerd
RECOVERY_BINARY_SOURCE_FILES           += $(TARGET_OUT_EXECUTABLES)/strace

# ==============================================================================
# NOTE FOR BUILDERS:
# You MUST also export these FOX_* variables in vendorsetup.sh or the build env:
#
#   export FOX_AB_DEVICE=1
#   export FOX_VIRTUAL_AB_DEVICE=1
#   export FOX_VANILLA_BUILD=1
#   export FOX_USE_UPDATED_MAGISKBOOT=1
#   export FOX_DELETE_AROMAFM=1
#   export FOX_REMOVE_AAPT=1
#
# Rest of OrangeFox variables (OF_*) are already set above.
# ==============================================================================
