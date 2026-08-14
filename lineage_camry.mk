#
# SPDX-FileCopyrightText: The LineageOS Project
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from ossi device
$(call inherit-product, device/oneplus/camry/device.mk)

# Inherit some common Lineage stuff.
$(call inherit-product, vendor/lineage/config/common_full_phone.mk)

PRODUCT_DEVICE := camry
PRODUCT_NAME := lineage_camry
PRODUCT_BRAND := oneplus
PRODUCT_MODEL := CPH2619
PRODUCT_MANUFACTURER := oplus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    BuildDesc="qssi_64-user 16 BP2A.250605.015 1780906271651 release-keys" \
    BuildFingerprint=OnePlus/CPH2619/OP5D49L1:16/BP2A.250605.015/U.R4T2.370c561-12d1-a45-12d89e9:user/release-keys
