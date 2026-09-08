#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oneplus/camry
KERNEL_MODULES_OUT := $(DEVICE_PATH)/prebuilts

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

# Partitions
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
TARGET_ODM_PROP += $(DEVICE_PATH)/props/odm.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/props/vendor.prop

# Include the proprietary files BoardConfig.
include vendor/oneplus/camry/BoardConfigVendor.mk
