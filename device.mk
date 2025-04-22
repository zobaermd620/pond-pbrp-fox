# Copyright (C) 2017-2023 The Android Open Source Project
# Copyright (C) 2014-2023 The Team Win LLC
# SPDX-License-Identifier: Apache-2.0

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base.mk)

# Installs gsi keys into ramdisk, to boot a developer GSI with verified boot.
$(call inherit-product, $(SRC_TARGET_DIR)/product/gsi_keys.mk)

# Configure Virtual A/B
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)

# Configure virtual_ab compression.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/compression.mk)

# Configure launch_with_vendor_ramdisk.mk
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Dynamic
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Virtual A/B
ENABLE_VIRTUAL_AB := true
AB_OTA_UPDATER := true

AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot

# Update engine
PRODUCT_PACKAGES_DEBUG += \
    update_engine_client

PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

# API
PRODUCT_SHIPPING_API_LEVEL := 32

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-mtkimpl \
    android.hardware.boot@1.0-impl-1.2-mtkimpl \
    android.hardware.boot@1.2-mtkimpl.recovery \
    bootctrl.mt6768

PRODUCT_PACKAGES += \
    android.hardware.boot@1.2-impl \
    android.hardware.boot@1.2-impl.recovery \
    android.hardware.boot@1.2-service

# Fastbootd
TW_INCLUDE_FASTBOOTD := true
PRODUCT_PACKAGES += \
    android.hardware.fastboot@1.0-impl-mock \
    fastbootd

# Health HAL
PRODUCT_PACKAGES += \
    android.hardware.health@2.1-impl \
    android.hardware.health@2.1-service \
    android.hardware.health@2.1-impl.recovery \
    android.hardware.health@2.1-service.rc

# Soong
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

PRODUCT_PACKAGES += \
    create_pl_dev \
    create_pl_dev.recovery

# Additional binaries & libraries needed for recovery
TARGET_RECOVERY_DEVICE_MODULES += \
    libkeymaster4 \
    libkeymaster41 \
    libpuresoftkeymasterdevice \
    libkeymaster_messages.vendor

TW_RECOVERY_ADDITIONAL_RELINK_LIBRARY_FILES += \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster4.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster41.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libpuresoftkeymasterdevice.so \
    $(TARGET_OUT_SHARED_LIBRARIES)/libkeymaster_messages.so



# OrangeFox Recovery Configuration
PRODUCT_PACKAGES += \
    orangefox \
    init.recovery.mt6768.rc \
    init.recovery.usb.rc \
    init.recovery.mt6768.rc.recovery

# Copy necessary OrangeFox init scripts into recovery ramdisk
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/fox/init.recovery.mt6768.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6768.rc \
    $(LOCAL_PATH)/recovery/fox/init.recovery.usb.rc:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.usb.rc \
    $(LOCAL_PATH)/recovery/fox/init.recovery.mt6768.rc.recovery:$(TARGET_COPY_OUT_RECOVERY)/root/init.recovery.mt6768.rc.recovery

# OrangeFox Specific Settings
TW_DEFAULT_LANGUAGE := en
OF_USE_GREEN_LED := 0
OF_NO_TREBLE_COMPATIBILITY_CHECK := 1
OF_PATCH_AVB20 := 1
OF_CLASSIC_LEDS_FUNCTION := 1
OF_DONT_PATCH_ENCRYPTED_DEVICE := 1
OF_SKIP_FBE_DECRYPTION := 1
OF_IGNORE_LOGICAL_MOUNT_ERRORS := true
OF_KEEP_FORCED_ENCRYPTION := true
OF_SUPPORT_ALL_BLOCK_OTA_UPDATES := true
OF_FIX_OTA_UPDATE_MANUAL_FLASH_ERROR := true
OF_USE_MAGISKBOOT := 1
OF_DISABLE_MIUI_OTA_BY_DEFAULT := true
OF_ENABLE_LPTOOLS := true
OF_ADVANCED_SECURITY := true
