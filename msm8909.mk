DEVICE_PACKAGE_OVERLAYS := device/qcom/msm8909/overlay

TARGET_USES_QCOM_BSP := true
ifeq ($(TARGET_USES_QCOM_BSP), true)
# Add QC Video Enhancements flag
TARGET_ENABLE_QC_AV_ENHANCEMENTS := true
endif #TARGET_USES_QCOM_BSP


#QTIC flag
-include $(QCPATH)/common/config/qtic-config.mk

# media_profiles and media_codecs xmls for msm8909
ifeq ($(TARGET_ENABLE_QC_AV_ENHANCEMENTS), true)
PRODUCT_COPY_FILES += device/qcom/msm8909/media/media_profiles_8909.xml:system/etc/media_profiles.xml \
                      device/qcom/msm8909/media/media_codecs_8909.xml:system/etc/media_codecs.xml \
                      device/qcom/msm8909/media/media_codecs_performance_8909.xml:system/etc/media_codecs_performance.xml
endif

PRODUCT_PROPERTY_OVERRIDES += \
       dalvik.vm.heapgrowthlimit=128m \
       dalvik.vm.heapminfree=6m
$(call inherit-product, device/qcom/common/common.mk)

PRODUCT_NAME := msm8909
PRODUCT_DEVICE := msm8909

ifeq ($(strip $(TARGET_USES_QTIC)),true)
# font rendering engine feature switch
-include $(QCPATH)/common/config/rendering-engine.mk
ifneq (,$(strip $(wildcard $(PRODUCT_RENDERING_ENGINE_REVLIB))))
    MULTI_LANG_ENGINE := REVERIE
#   MULTI_LANG_ZAWGYI := REVERIE
endif
endif

#Android EGL implementation
PRODUCT_PACKAGES += libGLES_android

# Audio configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8909/audio_policy.conf:system/etc/audio_policy.conf \
    device/qcom/msm8909/audio_effects.conf:system/vendor/etc/audio_effects.conf \
    device/qcom/msm8909/mixer_paths_qrd_skuh.xml:system/etc/mixer_paths_qrd_skuh.xml \
    device/qcom/msm8909/mixer_paths_qrd_skui.xml:system/etc/mixer_paths_qrd_skui.xml \
    device/qcom/msm8909/mixer_paths.xml:system/etc/mixer_paths.xml \
    device/qcom/msm8909/mixer_paths_msm8909_pm8916.xml:system/etc/mixer_paths_msm8909_pm8916.xml \
    device/qcom/msm8909/mixer_paths_wcd9326_i2s.xml:system/etc/mixer_paths_wcd9326_i2s.xml \
    device/qcom/msm8909/mixer_paths_skua.xml:system/etc/mixer_paths_skua.xml \
    device/qcom/msm8909/mixer_paths_skuc.xml:system/etc/mixer_paths_skuc.xml \
    device/qcom/msm8909/mixer_paths_skue.xml:system/etc/mixer_paths_skue.xml \
    device/qcom/msm8909/mixer_paths_qrd_skut.xml:system/etc/mixer_paths_qrd_skut.xml \
    device/qcom/msm8909/sound_trigger_mixer_paths.xml:system/etc/sound_trigger_mixer_paths.xml \
    device/qcom/msm8909/sound_trigger_platform_info.xml:system/etc/sound_trigger_platform_info.xml \
    device/qcom/msm8909/audio_platform_info.xml:system/etc/audio_platform_info.xml

PRODUCT_BOOT_JARS += qcom.fmradio \

PRODUCT_BOOT_JARS += tcmiface
PRODUCT_BOOT_JARS += qcmediaplayer

ifneq ($(strip $(QCPATH)),)
PRODUCT_BOOT_JARS += oem-services
PRODUCT_BOOT_JARS += com.qti.dpmframework
PRODUCT_BOOT_JARS += dpmapi
PRODUCT_BOOT_JARS += com.qti.location.sdk
endif

# Listen configuration file
PRODUCT_COPY_FILES += \
    device/qcom/msm8909/listen_platform_info.xml:system/etc/listen_platform_info.xml

# Feature definition files for msm8909
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.hardware.sensor.accelerometer.xml:system/etc/permissions/android.hardware.sensor.accelerometer.xml \
    frameworks/native/data/etc/android.hardware.sensor.compass.xml:system/etc/permissions/android.hardware.sensor.compass.xml \
    frameworks/native/data/etc/android.hardware.sensor.gyroscope.xml:system/etc/permissions/android.hardware.sensor.gyroscope.xml \
    frameworks/native/data/etc/android.hardware.sensor.light.xml:system/etc/permissions/android.hardware.sensor.light.xml \
    frameworks/native/data/etc/android.hardware.sensor.proximity.xml:system/etc/permissions/android.hardware.sensor.proximity.xml

#fstab.qcom
#Added by zhaohupeng to add msic\ssd\devinfo\config SW00184621 2016-02-22 begin
PRODUCT_PACKAGES += fstab.qcom \
                    misc.bin \
					ssd.bin \
					devinfo.bin \
					config.img
#Added by zhaohupeng to add msic\ssd\devinfo\config SW00184621 2016-02-22 end

#add sparse tools by baiyongjie 20131013
PRODUCT_PACKAGES += \
     rawprogram0.xml \
     checksparse.py
#added by zhangjie to add runtimetest and factorykit code from 650X (650X) for SW00183738 SW00183729 2016-01-29 begin
#added by zhangjie to add RawDataTest for (A650X_M) SW00185238 2016-03-02 begin
PRODUCT_PACKAGES += \
    RuntimeTest \
    FactoryKit \
    EngineeringMode \
    RawDataTest
#added by zhangjie to add RawDataTest for (A650X_M) SW00185238 2016-03-02 end
#added by zhangjie to add runtimetest and factorykit code from 650X (650X) for SW00183738 SW00183729 2016-01-29 end

# Added by wangjunbo to add YepSetProp SW00183378 2016-02-18 begin
PRODUCT_PACKAGES += YepSetProp
# Added by wangjunbo to add YepSetProp SW00183378 2016-02-18 end

# Added by chaofubang to add audio audio test SW00188625 20160617 start
PRODUCT_PACKAGES += audiotest
# Added by chaofubang to add audio audio test SW00188625 20160617 end

PRODUCT_PACKAGES += \
    libqcomvisualizer \
    libqcompostprocbundle \
    libqcomvoiceprocessing

#OEM Services library
PRODUCT_PACKAGES += oem-services
PRODUCT_PACKAGES += libsubsystem_control
PRODUCT_PACKAGES += libSubSystemShutdown

PRODUCT_PACKAGES += wcnss_service
#/* Modified by rentianzhi add AP diag module SW00183351 2016-01-28 begin */
PRODUCT_PACKAGES += hwdiag
#/* Modified by rentianzhi add AP diag module SW00183351 2016-01-28 end */

#wlan driver
#/* Modified by rentianzhi Add R/W WLAN MAC for diag module 2016-02-03 begin */
#/*Deleted by yujunfeng moved WCNSS_qcom_cfg.ini to product_config_xxx 2016-04-28 begin*/
PRODUCT_COPY_FILES += \
    device/qcom/msm8909/WCNSS_wlan_dictionary.dat:persist/WCNSS_wlan_dictionary.dat \
    device/qcom/msm8909/wlan_mac.bin:persist/wlan_mac.bin \
    device/qcom/msm8909/WCNSS_qcom_wlan_nv.bin:system/etc/firmware/wlan/prima/WCNSS_qcom_wlan_nv.bin
#/*Deleted by yujunfeng moved WCNSS_qcom_cfg.ini to product_config_xxx 2016-04-27 end*/
#/* Modified by rentianzhi Add R/W WLAN MAC for diag module 2016-02-03 end */

# Added by wangjunbo for factory current test (A6505) SW00188623 2016-06-17 begin
PRODUCT_COPY_FILES += \
    device/qcom/msm8909/init.currenttest.timeout.sh:system/etc/init.currenttest.timeout.sh
# Added by wangjunbo for factory current test (A6505) SW00188623 2016-06-17 end

PRODUCT_PACKAGES += \
    wpa_supplicant_overlay.conf \
    p2p_supplicant_overlay.conf

# MIDI feature
#/*Deleted by shenxinyu for cts android.software.midi  2016-05-25 begin*/
#PRODUCT_COPY_FILES += \
#   frameworks/native/data/etc/android.software.midi.xml:system/etc/permissions/android.software.midi.xml
#/*Deleted by shenxinyu for cts android.software.midi  2016-05-25 end*/
#ANT+ stack
PRODUCT_PACKAGES += \
AntHalService \
libantradio \
antradio_app

# Defined the locales
#Modified by liqiang for launage list (A650X) SW00188549 20160627 begin
#Modified by liqiang for add en_za (A650X) A6501M-2875 20160801 begin
PRODUCT_LOCALES := zh_CN en_US en_AU en_IN en_ZA fr_FR it_IT es_ES et_EE de_DE nl_NL cs_CZ pl_PL ja_JP zh_TW zh_HK ru_RU ko_KR nb_NO es_US da_DK el_GR tr_TR pt_PT pt_BR rm_CH sv_SE bg_BG ca_ES en_GB fi_FI hi_IN hr_HR hu_HU in_ID iw_IL lt_LT lv_LV ro_RO sk_SK sl_SI sr_RS uk_UA vi_VN tl_PH ar_EG fa_IR th_TH sw_TZ ms_MY af_ZA zu_ZA am_ET hi_IN en_XA ar_XB fr_CA km_KH lo_LA ne_NP mn_MN hy_AM az_AZ ka_GE my_MM mr_IN ml_IN is_IS mk_MK ky_KG eu_ES gl_ES bn_BD ta_IN kn_IN te_IN uz_UZ ur_PK kk_KZ en_NZ en_SG nl_BE en_CA en_IE fr_BE fr_CH de_LI de_AT de_CH it_CH bn_IN my_MM be_BY uz_UZ am_ET ar_IL
#Modified by liqiang for add en_za (A650X) A6501M-2875 20160801 end
#Modified by liqiang for launage list (A650X) SW00188549 20160627 end

# mayingda 2016.05.20 modified to del Android_M res-overlay , 650X, SW00187993 , begin
# Add the overlay path
PRODUCT_PACKAGE_OVERLAYS := $(QCPATH)/qrdplus/Extension/res-overlay \
        $(PRODUCT_PACKAGE_OVERLAYS)
# mayingda 2016.05.20 modified to del Android_M res-overlay , 650X, SW00187993 , end

#add by zhaohupeng for include product_config for A650x 2016-02-04 begin
ifeq ($(findstring AR6500,$(YEP_PRODUCT_NAME)),AR6500)
	include product_config_A6500/product_config.mk
endif

ifeq ($(findstring AR6501,$(YEP_PRODUCT_NAME)),AR6501)
        include product_config_A6501/product_config.mk
endif

ifeq ($(findstring AR6502,$(YEP_PRODUCT_NAME)),AR6502)
        include product_config_A6502/product_config.mk
endif

ifeq ($(findstring AR6505,$(YEP_PRODUCT_NAME)),AR6505)
        include product_config_A6505/product_config.mk
endif

#add by zhaohupeng for include product_config for A650x 2016-02-04 end

# <A650X-m zhaohupeng 2016-2-18 begin

PRODUCT_PROPERTY_OVERRIDES += \
	persist.sys.strictmode.visual=0 \
	persist.sys.strictmode.disable=1
	
# A650X-m zhaohupeng 2016-2-18 end >

# Sensor HAL conf file
PRODUCT_COPY_FILES += \
    device/qcom/msm8909/sensors/hals.conf:system/etc/sensors/hals.conf
#add by shenxinyu for update ISO for A6505 SW00189102 2016-07-25 begin
ifeq ($(YEP_PRODUCT_NAME),AR6505)
    PRODUCT_COPY_FILES += device/qcom/msm8909/YEPAUTOINST_ARH_ROW.ISO:system/etc/YEPAUTOINST.ISO
else
        ifeq ($(findstring PRC,$(PRODUCT_EXTERNAL_VERSION)),PRC)
            PRODUCT_COPY_FILES += device/qcom/msm8909/YEPAUTOINST_PRC.ISO:system/etc/YEPAUTOINST.ISO
        else
            PRODUCT_COPY_FILES += device/qcom/msm8909/YEPAUTOINST_ROW.ISO:system/etc/YEPAUTOINST.ISO
        endif
endif
#add by shenxinyu for update ISO for A6505 SW00189102 2016-07-25 end
#add by wangqi for SW00188085 to add tptest begin
PRODUCT_COPY_FILES += packages/yepapp/YepFactoryKit/assets/Conf_MultipleTest.ini:system/etc/Conf_MultipleTest.ini
#add by wangqi for SW00188085 to add tptest end
#Add by tansen for Widevine fuction 20160408 SW00186672 begin
include vendor/qcom/proprietary/widevine/config.mk
#Add by tansen for Widevine fuction 20160408 SW00186672 end

#Add by wangtianyu for country list 20160425 SW00146745 begin
PRODUCT_PACKAGES += \
         CountryList
#Add by wangtianyu for country list 20160425 SW00146745 end
#Add by wangtianyu for country list 20160425 SW00183743 begin
PRODUCT_PACKAGES += \
        setproperties
#Add by wangtianyu for country list 20160425 SW00183743 end

