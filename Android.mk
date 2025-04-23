#
# Copyright (C) 2025
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := $(call my-dir)

ifneq ($(filter pond lake,$(TARGET_DEVICE)),)

# Include custom recovery init scripts
include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.mt6768.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := recovery/pbrp/init.recovery.mt6768.rc
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.usb.rc
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := recovery/pbrp/init.recovery.usb.rc
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

include $(CLEAR_VARS)
LOCAL_MODULE := init.recovery.mt6768.rc.recovery
LOCAL_MODULE_CLASS := ETC
LOCAL_SRC_FILES := recovery/pbrp/init.recovery.mt6768.rc.recovery
LOCAL_MODULE_PATH := $(TARGET_RECOVERY_ROOT_OUT)
include $(BUILD_PREBUILT)

endif
