#
# Copyright (C) 2021-2025 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from waffle device
$(call inherit-product, device/oneplus/camry/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_NAME := lineage_camry
PRODUCT_DEVICE := camry
PRODUCT_MANUFACTURER := OnePlus
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := CPH2621

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="OP5D49L1-user 16 BP2A.250605.015 1780906271651 release-keys" \
    BuildFingerprint=OnePlus/CPH2621EEA/OP5D49L1:16/BP2A.250605.015/U.R4T2.370c561-12d1a45-12d89e9:user/release-keys \
    DeviceName=OP5D49L1 \
    DeviceProduct=CPH2621 \
    SystemDevice=OP5D49L1 \
    SystemName=CPH2621
