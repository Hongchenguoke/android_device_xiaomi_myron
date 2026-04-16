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
# 	Device: Xiaomi Myron (Redmi K90 Pro Max / POCO F8 Ultra)
# 	Platform: Snapdragon 8 Elite Gen 5 (SM8850 / canoe)
# 	System: Android 16 / HyperOS 3.0 / GKI 2.0 / Virtual A/B
# 	100% 真机验证配置
#
export LC_ALL="C"

# ─── A/B 与分区架构配置 ───────────────────────────────────────────────────────
# 独立Recovery分区的Virtual A/B设备
export FOX_AB_DEVICE=1
export OF_AB_DEVICE_WITH_RECOVERY_PARTITION=1
export FOX_VIRTUAL_AB_DEVICE=1
# 新平台使用AIDL版BootControl
export OF_USE_AIDL_BOOT_CONTROL=1

# ─── API 预编译支持 ───────────────────────────────────────────────────────────
# 适配API 34预编译库
export FOX_ADD_API_V34_PREBUILTS=1

# ─── 动态分区管理工具 ──────────────────────────────────────────────────────────
# dmctl 动态分区控制
export OF_USE_DMCTL=1
# Super分区完整大小（来自真机blockdev验证）
export OF_DYNAMIC_FULL_SIZE=14495514624
# 格式化调试信息
export OF_DISPLAY_FORMAT_FILESYSTEMS_DEBUG_INFO=1
# 默认Data分区格式为F2FS（真机默认格式）
export OF_FORCE_DATA_FORMAT_F2FS=1
# 格式化Data后自动清理Metadata分区
export OF_WIPE_METADATA_AFTER_DATAFORMAT=1
# 备份功能Bug修复
export OF_WORKAROUND_BACKUP_BUG=1

# ─── 压缩与二进制工具 ─────────────────────────────────────────────────────────
# LZ4压缩支持
export OF_USE_LZ4_COMPRESSION=1
# 集成所有必要的工具二进制
export FOX_USE_TAR_BINARY=1
export FOX_USE_SED_BINARY=1
export FOX_USE_LZ4_BINARY=1
export FOX_USE_ZSTD_BINARY=1
export FOX_USE_DATE_BINARY=1
export FOX_USE_GREP_BINARY=1
export FOX_USE_BUSYBOX_BINARY=1
export FOX_USE_XZ_UTILS=1
export FOX_USE_FSCK_EROFS_BINARY=1  # EROFS文件系统检查工具（真机系统分区格式）
export FOX_USE_PATCHELF_BINARY=1
export FOX_USE_UPDATED_MAGISKBOOT=1 # 新版MagiskBoot支持Android 16
# Magisk安装器自动移入Ramdisk
export FOX_MOVE_MAGISK_INSTALLER_TO_RAMDISK=1

# ─── 兼容性与特殊处理 ───────────────────────────────────────────────────────
# TWRP兼容模式
export OF_TWRP_COMPATIBILITY_MODE=1
# 解密后不重启（防止新平台解密后重启Bug）
export OF_NO_RELOAD_AFTER_DECRYPTION=1
# 跳过Treble兼容性检查
export OF_NO_TREBLE_COMPATIBILITY_CHECK=1
# 删除旧的AromaFM（新Recovery不再需要）
export FOX_DELETE_AROMAFM=1
# 关闭MIUI补丁警告
export OF_NO_MIUI_PATCH_WARNING=1
# 默认禁用MIUI OTA（防止覆盖Recovery）
export OF_DISABLE_MIUI_OTA_BY_DEFAULT=1
# 禁用绿色LED（小米机型使用自定义指示灯）
export OF_USE_GREEN_LED=0

# ─── 内核配置 ───────────────────────────────────────────────────────────────
# 使用预编译内核（GKI 2.0标准）
export OF_FORCE_PREBUILT_KERNEL=1

# ─── 显示与硬件配置 ──────────────────────────────────────────────────────────
# 屏幕参数（100%来自真机验证，修正了旧脚本的错误高度）
export OF_SCREEN_H=2608
export OF_STATUS_H=141
export OF_STATUS_INDENT_LEFT=48
export OF_STATUS_INDENT_RIGHT=48
# 挖孔屏避让（开启状态栏挖孔隐藏）
export OF_HIDE_NOTCH=1
# 禁止禁用导航栏（全面屏机型）
export OF_ALLOW_DISABLE_NAVBAR=0
# 选项列表数量
export OF_OPTIONS_LIST_NUM=6
# 使用OrangeFox默认主题（修复默认紫色主题的问题）
export FOX_USE_DEFAULT_THEME=1

# ─── 设置持久化 ──────────────────────────────────────────────────────────────
# 设置存储在Persist分区（不会被格式化，永久保存）
export FOX_SETTINGS_ROOT_DIRECTORY=/persist
# 允许提前加载设置
export FOX_ALLOW_EARLY_SETTINGS_LOAD=1

# ─── Root方案支持 ────────────────────────────────────────────────────────────
# 全系列Root支持：Magisk / KernelSU / KernelSU Next / Sukisu
export FOX_ENABLE_KERNELSU_SUPPORT=1
export FOX_ENABLE_KERNELSU_NEXT_SUPPORT=1
export FOX_ENABLE_SUKISU_SUPPORT=1
# Magisk默认路径
export OF_MAGISK="/tmp/misc/Magisk.zip"
export FOX_USE_SPECIFIC_MAGISK_ZIP="/tmp/misc/Magisk.zip"

# ─── 维护者与版本信息 ────────────────────────────────────────────────────────
export FOX_BUILD_DEVICE="myron"
export FOX_VARIANT="Xiaomi_myron_Redmi_K90_Pro_Max"
# 自动生成维护者版本号（日期格式）
export FOX_MAINTAINER_PATCH_VERSION=$(date +%y%m%d)
# 维护者信息
export OF_MAINTAINER="MissMyTime"