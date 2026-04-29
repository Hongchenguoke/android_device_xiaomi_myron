#!/bin/bash
#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2020-2026 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses />.
#
# 	Device: Xiaomi Myron (Redmi K90 Pro Max )
# 	Platform: Snapdragon 8 Elite Gen 5 (SM8850 / canoe)
# 	System: Android 16 / HyperOS 3.0 / GKI 2.0 / Virtual A/B
# 	100% device-verified configuration
#
export LC_ALL="C"

# ─── A/B & partition architecture configuration ─────────────────────────────────────────
# Virtual A/B device with dedicated recovery partition
export FOX_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
export FOX_VIRTUAL_AB_DEVICE=1
# Use AIDL BootControl for new platforms
export OF_USE_AIDL_BOOT_CONTROL=1

# ─── API prebuilt support ───────────────────────────────────────────────────────────────
# Add prebuilt libraries for API 34
export FOX_ADD_API_V34_PREBUILTS=1

# ─── Dynamic partition management tools ────────────────────────────────────────────────
# dmctl for dynamic partition control
export OF_USE_DMCTL=1
# Full super partition size (verified via blockdev on device)
export OF_DYNAMIC_FULL_SIZE=14495514624
# Show debug info during filesystem formatting
export OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO=1
# Default data partition format is F2FS (device default)
export OF_FORCE_DATA_FORMAT_F2FS=1
# Automatically wipe metadata partition after formatting data
export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
# Backup bug workaround
export OF_WORKAROUND_BACKUP_BUG=1

# ─── Compression & binary tools ────────────────────────────────────────────────────────
# LZ4 compression support
export OF_USE_LZ4_COMPRESSION=1
# Include essential binary tools
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_DATE_BINARY=1
export FOX_USE_GREP_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_FSCK_EROFS_BINARY=1  # EROFS filesystem checker (device system partitions use EROFS)
export FOX_USE_PATCHELF_BINARY=1
export FOX_USE_UPDATED_MAGISKBOOT=1 # New MagiskBoot supports Android 16
# Move Magisk installer to ramdisk
export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1

# ─── Compatibility & special handling ──────────────────────────────────────────────────
# TWRP compatibility mode
export OF_TWRP_COMPATIBILITY_MODE=1
# Do not reload after decryption (prevents reboot bug on new platforms)
export OF_NO_RELOAD_AFTER_DECRYPTION=1
# Skip Treble compatibility check
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
# Remove old AromaFM (no longer needed for new recovery)
export FOX_DELETE_AROMAFM=1
# Suppress MIUI patch warnings
export OF_NO_MIUI_PATCH_WARNING=1
# Disable MIUI OTA by default (prevents overwriting recovery)
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
# Disable green LED (Xiaomi devices use custom indicator)
export OF_USE_GREEN_LED=0

# ─── Kernel configuration ──────────────────────────────────────────────────────────────
# Use prebuilt kernel (GKI 2.0 standard)
export OF_FORCE_PREBUILT_KERNEL=1

# ─── Display & hardware configuration ──────────────────────────────────────────────────
# Screen parameters
export OF_SCREEN_H=2608
export OF_STATUS_H=144
export OF_STATUS_INDENT_LEFT=96
export OF_STATUS_INDENT_RIGHT=96
# Hide notch (hide punch-hole by black status bar)
export OF_HIDE_NOTCH=1
# Disable navbar disabling (full-screen device)
export OF_ALLOW_DISABLE_NAVBAR=0
# Number of options in list
export OF_OPTIONS_LIST_NUM=6
# Use OrangeFox default theme
export FOX_USE_DEFAULT_THEME=1

# ─── Settings persistence ──────────────────────────────────────────────────────────────
# Store settings in persist partition (never wiped, permanent)
export FOX_SETTINGS_ROOT_DIRECTORY=/persist
# Allow early settings loading
export FOX_ALLOW_EARLY_SETTINGS_LOAD=1

# ─── Root solution support ────────────────────────────────────────────────────────────
# Full root support: Magisk / KernelSU / KernelSU Next / Sukisu
export FOX_ENABLE_KERNELSU_SUPPORT=1
export FOX_ENABLE_KERNELSU_NEXT_SUPPORT=1
export FOX_ENABLE_SUKISU_SUPPORT=1
# Default Magisk path
export OF_MAGISK="/tmp/misc/Magisk.zip"
export FOX_USE_SPECIFIC_MAGISK_ZIP="/tmp/misc/Magisk.zip"

# ─── Maintainer & version info ────────────────────────────────────────────────────────
export FOX_BUILD_DEVICE="myron"
export FOX_VARIANT="Xiaomi_myron_Redmi_K90_Pro_Max"
# Auto-generate maintainer version number (date format)
export FOX_MAINTAINER_PATCH_VERSION=$(date +%y%m%d)
# Maintainer name
export OF_MAINTAINER="MissMyTime"
