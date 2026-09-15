#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oneplus/camry

# A/B
AB_OTA_UPDATER := true
AB_OTA_PARTITIONS += \
    vendor \
    recovery \
    system \
    vendor_dlkm \
    init_boot \
    vendor_boot \
    odm \
    dtbo \
    boot \
    system_dlkm \
    product \
    system_ext

BOARD_SUPER_PARTITION_SIZE := 12884901888

# Assert
TARGET_OTA_ASSERT_DEVICE := OP5D49L1

# Display
TARGET_SCREEN_DENSITY := 395

# Prebuilts
TARGET_FORCE_PREBUILT_KERNEL := true
ifeq ($(TARGET_FORCE_PREBUILT_KERNEL),true)
include device/oneplus/camry-kernel/BoardConfig.mk
endif

# Properties
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/odm.prop
TARGET_ODM_DLKM_PROP += $(DEVICE_PATH)/odm_dlkm.prop

# Inherit the proprietary files
-include vendor/oneplus/camry/BoardConfigVendor.mk
