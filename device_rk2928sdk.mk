$(call inherit-product, $(SRC_TARGET_DIR)/product/languages_full.mk)

# The gps config appropriate for this device
$(call inherit-product, device/common/gps/gps_us_supl.mk)

$(call inherit-product-if-exists, vendor/rockchip/rk2928sdk/rk2928sdk-vendor.mk)

DEVICE_PACKAGE_OVERLAYS += device/rockchip/rk2928sdk/overlay

LOCAL_PATH := device/rockchip/rk2928sdk
ifeq ($(TARGET_PREBUILT_KERNEL),)
	LOCAL_KERNEL := $(LOCAL_PATH)/kernel
else
	LOCAL_KERNEL := $(TARGET_PREBUILT_KERNEL)
endif

PRODUCT_COPY_FILES += \
    $(LOCAL_KERNEL):kernel

$(call inherit-product, build/target/product/full.mk)

PRODUCT_BUILD_PROP_OVERRIDES += BUILD_UTC_DATE=0
PRODUCT_NAME := full_rk2928sdk
PRODUCT_DEVICE := rk2928sdk


# Copy Recovery-Ramdisk files
PRODUCT_COPY_FILES += \
    $(LOCAL_PATH)/ramdisk/rk29xxnand_ko.ko.3.0.36+:recovery/root/rk29xxnand_ko.ko \
    $(LOCAL_PATH)/ramdisk/init.rk2928board.rc:recovery/root/init.rk2928board.rc \
    $(LOCAL_PATH)/ramdisk/init.rk2928board.usb.rc:recovery/root/init.rk2928board.usb.rc \
    $(LOCAL_PATH)/ramdisk/ueventd.rk2928board.rc:recovery/root/ueventd.rk2928board.rc

# enable ADB
PRODUCT_PROPERTY_OVERRIDES := \
        service.adb.root=1 \
        ro.secure=0 \
        ro.allow.mock.location=1 \
        ro.debuggable=1
