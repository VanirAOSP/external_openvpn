LOCAL_PATH:= $(call my-dir)

#on a 32bit maschine run ./configure --enable-password-save --disable-pkcs11 --with-ifconfig-path=/system/bin/ifconfig --with-route-path=/system/bin/route
#from generated Makefile copy variable contents of openvpn_SOURCES to common_SRC_FILES
# append missing.c to the end of the list
# missing.c defines undefined functions.
# in tun.c replace /dev/net/tun with /dev/tun

include $(CLEAR_VARS)

openvpn_SRC_FILES:= $(wildcard $(LOCAL_PATH)/src/openvpn/*.c)
openvpn_SRC_FILES:= $(openvpn_SRC_FILES:$(LOCAL_PATH)/%=%)

plugin_SRC_FILES:= $(wildcard $(LOCAL_PATH)/src/plugins/*.c)
plugin_SRC_FILES:= $(plugin_SRC_FILES:$(LOCAL_PATH)/%=%)

LOCAL_SRC_FILES := \
	$(openvpn_SRC_FILES) \
	$(plugin_SRC_FILES)

LOCAL_CFLAGS := -DANDROID_CHANGES -DHAVE_CONFIG_H -Wno-unused-parameter

LOCAL_C_INCLUDES := \
	bionic \
	bionic/libstdc++/include \
	external/openssl \
	external/openssl/include \
	external/openssl/crypto \
	external/lzo/include \
	external/openvpn/include \
	external/openvpn/src/compat \
	external/openvpn \
	libcore/include \
	system/core/libnetutils \
	system/security/keystore

LOCAL_CLANG:=true

LOCAL_ADDITIONAL_DEPENDENCIES:=$(LOCAL_PATH)/Android.mk

LOCAL_SHARED_LIBRARIES := libcutils libkeystore_binder libnetutils libssl libcrypto liblzo libstlport liblog libdl

LOCAL_LDLIBS := -ldl
LOCAL_PRELINK_MODULE := false

LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := openvpn
LOCAL_MODULE_PATH := $(TARGET_OUT_OPTIONAL_EXECUTABLES)
include $(BUILD_EXECUTABLE)
