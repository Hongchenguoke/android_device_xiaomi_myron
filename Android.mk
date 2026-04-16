# =============================================================================  
# Android.mk  
# GNU Make entry point for OrangeFox fox-14.1  
# Device: Xiaomi Myron (Redmi K90 Pro Max)  
#  
# Gates all sub-makefiles behind TARGET_DEVICE check to prevent  
# inclusion when building for other devices in the same source tree.  
# =============================================================================  
  
LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),myron)
    include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
