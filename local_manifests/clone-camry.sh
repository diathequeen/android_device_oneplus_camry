# Clone device/oneplus trees
git clone https://github.com/diathequeen/android_device_oneplus_camry.git device/oneplus/camry
git clone https://github.com/diathequeen/android_device_oneplus_camry-kernel.git device/oneplus/camry-kernel
git clone https://github.com/diathequeen/android_device_oneplus_sm6375-common.git device/oneplus/sm6375-common

# Clone custom HALs
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
