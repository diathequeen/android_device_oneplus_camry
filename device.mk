#
# Copyright (C) 2021-2026 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# AAPT
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxxhdpi

# Boot animation
TARGET_SCREEN_HEIGHT := 2400
TARGET_SCREEN_WIDTH := 1080

# Audio
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/audio/a2dp_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/a2dp_audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/audio_policy_volumes.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio_policy_volumes.xml \
    $(LOCAL_PATH)/configs/audio/bluetooth_qti_audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/bluetooth_qti_audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/audio_policy_configuration.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/mixer_paths_blair_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/mixer_paths_blair_mtp.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/mixer_paths_blair_mtp_usbc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/mixer_paths_blair_mtp_usbc.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/mixer_paths_blair_qrd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/mixer_paths_blair_qrd.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/resourcemanager_blair_mtp.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/resourcemanager_blair_mtp.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/resourcemanager_blair_mtp_usbc.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/resourcemanager_blair_mtp_usbc.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair/resourcemanager_blair_qrd.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair/resourcemanager_blair_qrd.xml \
    $(LOCAL_PATH)/configs/audio/sku_blair_qssi/audio_policy_configuration.xml:$(TARGET_COPY_OUT_VENDOR)/etc/audio/sku_blair_qssi/audio_policy_configuration.xml

# Init
PRODUCT_PACKAGES += \
    init.device.rc

# Display
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/configs/display/displayconfig.xml:$(TARGET_COPY_OUT_VENDOR)/etc/displayconfig/display_id_4630946716506123905.xml

# Regional properties
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/recovery/root/vendor/odm/etc/23881/flags.prop:$(TARGET_COPY_OUT_ODM)/etc/23881/flags.prop

# Keymint
PRODUCT_PACKAGES += \
    android.hardware.security.keymint3-service.strongbox.nxp \
    android.hardware.weaver-service.nxp

# LiveDisplay
$(call soong_config_set_bool,OPLUS_LINEAGE_LIVEDISPLAY_HAL,ENABLE_SE,false)

# PowerShare
PRODUCT_PACKAGES += \
    vendor.lineage.powershare-service.oplus

# Soong namespaces
PRODUCT_SOONG_NAMESPACES += \
    $(LOCAL_PATH)

# Touch features
$(call soong_config_set_bool,OPLUS_LINEAGE_TOUCH_HAL,ENABLE_GM,true)

# Vibrator
PRODUCT_PACKAGES += \
    vendor.qti.hardware.vibrator.service

$(call soong_config_set_bool,qti_vibrator,use_effect_stream,true)

# WiFi firmware symlinks
PRODUCT_PACKAGES += \
    firmware_wlan_mac.bin_symlink \
    firmware_WCNSS_qcom_cfg.ini_symlink

# Inherit from the common OEM chipset makefile.
$(call inherit-product, device/oneplus/sm6375-common/common.mk)

# Inherit from the proprietary files makefile.
$(call inherit-product, vendor/oneplus/camry/camry-vendor.mk)
