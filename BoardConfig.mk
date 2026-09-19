#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oneplus/camry

# Include the common OEM chipset BoardConfig.
include device/oneplus/sm6375-common/BoardConfigCommon.mk

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
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/properties/system.prop
TARGET_VENDOR_PROP += $(DEVICE_PATH)/properties/vendor.prop
TARGET_PRODUCT_PROP += $(DEVICE_PATH)/properties/product.prop
TARGET_SYSTEM_EXT_PROP += $(DEVICE_PATH)/properties/system_ext.prop
TARGET_SYSTEM_DLKM_PROP += $(DEVICE_PATH)/properties/system_dlkm.prop
TARGET_ODM_PROP += $(DEVICE_PATH)/properties/odm.prop

# Include the proprietary files BoardConfig.
include vendor/oneplus/camry/BoardConfigVendor.mk
