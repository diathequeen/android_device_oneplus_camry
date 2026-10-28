Copyright (C) 2026 The LineageOS Project

Device tree for OnePlus Nord CE4 Lite 5G
=========================================
# How to use?
**Clone the repo to device/oneplus/camry**
```
git clone https://github.com/diathequeen/android_device_oneplus_camry.git -b lineage-24.0 device/oneplus/camry
```

**To start a build (from the root of lineage source)**
```
source build/envsetup.sh
lineage_camry-cp2a-user # or userdebug
mka bacon
```

**To develop, to extract blobs, etc..**
```
./extract-files.py /path/to/ota/dump
```
*A vendor tree should generate.*

## ***Simple reminder y'all***
All `vendor/oneplus/camry` errors (e.g. `undefined dependency`, `partitions are different !(odm) !(vendor)`) means *you need to apply fixes to changes you made inside* `device/oneplus/camry`, especially `proprietary-files.txt` or `proprietary-firmware.txt` that `extract-files.py` *parses* to *generate vendor tree*. Every error that doesn't mention vendor must be having problems with BoardConfig.mk or device.mk.

### When using extract-files.py
Note that it generates `vendor/oneplus/sm6375-common` too - don't forget to use these two together to patch, commit and fix.

## Don't forget cloning Custom HALs (thanks to spring repo)
```
# Custom HALs
rm -rf hardware/qcom-caf/common
git clone https://github.com/spring4ever/android_hardware_qcom-caf_common hardware/qcom-caf/common

git clone https://github.com/spring4ever/android_vendor_qcom_opensource_agm hardware/qcom-caf/sm6375-6.1/audio/agm
git clone https://github.com/spring4ever/android_vendor_qcom_opensource_arpal-lx hardware/qcom-caf/sm6375-6.1/audio/pal
git clone https://github.com/spring4ever/android_hardware_qcom_audio-ar hardware/qcom-caf/sm6375-6.1/audio/primary-hal
git clone https://github.com/spring4ever/android_vendor_qcom_opensource_audioreach-graphservices hardware/qcom-caf/sm6375-6.1/audio/graphservices
git clone https://github.com/spring4ever/android_hardware_qcom_display hardware/qcom-caf/sm6375-6.1/display
git clone https://github.com/spring4ever/android_vendor_qcom_opensource_dataipa hardware/qcom-caf/sm6375-6.1/dataipa
git clone https://github.com/spring4ever/android_vendor_qcom_opensource_data-ipa-cfg-mgr hardware/qcom-caf/sm6375-6.1/data-ipa-cfg-mgr
ln -sf ../common/os_pickup_qssi.bp hardware/qcom-caf/sm6375-6.1/Android.bp
```
