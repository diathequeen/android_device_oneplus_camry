#!/vendor/bin/sh
# Copyright (c) 2012-2018, 2020-2021 The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
#       copyright notice, this list of conditions and the following
#       disclaimer in the documentation and/or other materials provided
#       with the distribution.
#     * Neither the name of The Linux Foundation nor the names of its
#       contributors may be used to endorse or promote products derived
#      from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED "AS IS" AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT
# ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS
# BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
# BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
# OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
# IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

# Changes from Qualcomm Innovation Center are provided under the following license:
# Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
# SPDX-License-Identifier: BSD-3-Clause-Clear
#

# Set platform variables
soc_hwplatform=`cat /sys/devices/soc0/hw_platform 2> /dev/null`
soc_machine=`cat /sys/devices/soc0/machine 2> /dev/null`
soc_machine=${soc_machine:0:2}
soc_id=`cat /sys/devices/soc0/soc_id 2> /dev/null`

#
# Check ESOC for external modem
#
# Note: currently only a single MDM/SDX is supported
#
esoc_name=`cat /sys/bus/esoc/devices/esoc0/esoc_name 2> /dev/null`

target=`getprop ro.board.platform`

#
# Override USB default composition
#
if [ "$(getprop ro.build.type)" != "user" ]; then
  # If USB persist config not set, set default configuration
  if [ "$(getprop persist.vendor.usb.config)" == "" ]; then
    if [ "$esoc_name" != "" ]; then
	  setprop persist.vendor.usb.config diag,diag_mdm,qdss,qdss_mdm,serial_cdev,dpl,rmnet,adb
    else
	  case "$(getprop ro.baseband)" in
	      "apq")
	          setprop persist.vendor.usb.config diag,adb
	      ;;
	      *)
	      case "$soc_hwplatform" in
	          "Dragon" | "SBC")
	              setprop persist.vendor.usb.config diag,adb
	          ;;
                  *)
		  case "$soc_machine" in
		    "SA")
	              setprop persist.vendor.usb.config diag,adb
		    ;;
		    *)
	            case "$target" in
	              "msm8996")
	                  setprop persist.vendor.usb.config diag,serial_cdev,serial_tty,rmnet_ipa,mass_storage,adb
		      ;;
	              "msm8909")
		          setprop persist.vendor.usb.config diag,serial_smd,rmnet_qti_bam,adb
		      ;;
	              "msm8937")
			    if [ -d /config/usb_gadget ]; then
				       setprop persist.vendor.usb.config diag,serial_cdev,rmnet,dpl,adb
			    else
			               case "$soc_id" in
				               "313" | "320")
				                  setprop persist.vendor.usb.config diag,serial_smd,rmnet_ipa,adb
				               ;;
				               *)
				                  setprop persist.vendor.usb.config diag,serial_smd,rmnet_qti_bam,adb
				               ;;
			               esac
			    fi
		      ;;
	              "msm8953")
			      if [ -d /config/usb_gadget ]; then
				      setprop persist.vendor.usb.config diag,serial_cdev,rmnet,dpl,adb
			      else
				      setprop persist.vendor.usb.config diag,serial_smd,rmnet_ipa,adb
			      fi
		      ;;
	              "msm8998" | "sdm660" | "apq8098_latv")
		          setprop persist.vendor.usb.config diag,serial_cdev,rmnet,adb
		      ;;
	              "monaco")
		          setprop persist.vendor.usb.config diag,qdss,rmnet,adb
		      ;;
	              "sdm845" | "sdm710")
		          setprop persist.vendor.usb.config diag,serial_cdev,rmnet,dpl,adb
		      ;;
	              "msmnile" | "sm6150" | "trinket" | "lito" | "atoll" | "bengal" | "lahaina" | "holi" | \
				  "taro" | "kalama" | "pineapple" | "blair")
			  setprop persist.vendor.usb.config diag,serial_cdev,rmnet,dpl,qdss,adb
		      ;;
		      "gen4")
			  setprop persist.vendor.usb.config adb
		      ;;
	              *)
		          setprop persist.vendor.usb.config diag,adb
		      ;;
                    esac
		    ;;
		  esac
	          ;;
	      esac
	      ;;
	  esac
      fi
  fi
else # for user build let persist.sys.usb.config dictate the default composition
    setprop persist.vendor.usb.config ""
fi

# This check is needed for GKI 1.0 targets where QDSS is not available
if [ "$(getprop persist.vendor.usb.config)" == "diag,serial_cdev,rmnet,dpl,qdss,adb" -a \
     ! -d /config/usb_gadget/g1/functions/qdss.qdss ]; then
      setprop persist.vendor.usb.config diag,serial_cdev,rmnet,dpl,adb
fi

# Start peripheral mode on primary USB controllers for Automotive platforms
case "$soc_machine" in
    "SA")
	if [ -f /sys/bus/platform/devices/a600000.ssusb/mode ]; then
	    default_mode=`cat /sys/bus/platform/devices/a600000.ssusb/mode`
	    case "$default_mode" in
		"none")
		    echo peripheral > /sys/bus/platform/devices/a600000.ssusb/mode
		;;
	    esac
	fi
    ;;
esac

# check configfs is mounted or not
if [ -d /config/usb_gadget ]; then
	machine_type=`cat /sys/devices/soc0/machine`

	# Chip ID & serial are used for unique MSM identification in Product String
	# If not present, then omit them instead of using 0x00000000
	msm_chipid=`cat /sys/devices/soc0/nproduct_id`;
	if [ "$msm_chipid" != "" ]; then
		msm_chipid_hex=`printf _CID:%04X $msm_chipid`
	fi

	msm_serial=`cat /sys/devices/soc0/serial_number`;
	if [ "$msm_serial" != "" ]; then
		msm_serial_hex=`printf _SN:%08X $msm_serial`
	fi

	setprop vendor.usb.product_string "$machine_type-$soc_hwplatform$msm_chipid_hex$msm_serial_hex"

	# ADB requires valid iSerialNumber; if ro.serialno is missing, use dummy
	serialnumber=`cat /config/usb_gadget/g1/strings/0x409/serialnumber 2> /dev/null`
	if [ "$serialnumber" == "" ]; then
		serialno=1234567
		echo $serialno > /config/usb_gadget/g1/strings/0x409/serialnumber
	fi
	setprop vendor.usb.configfs 1
fi

#
# Initialize RNDIS Diag option. If unset, set it to 'none'.
#
diag_extra=`getprop persist.vendor.usb.config.extra`
if [ "$diag_extra" == "" ]; then
	setprop persist.vendor.usb.config.extra none
fi

# enable rps cpus on msm8937 target
setprop vendor.usb.rps_mask 0
case "$soc_id" in
	"294" | "295" | "353" | "354")
		setprop vendor.usb.rps_mask 40
	;;
esac

#
# Initialize UVC conifguration.
#
if [ -d /config/usb_gadget/g1/functions/uvc.0 ]; then
	setprop vendor.usb.uvc.function.init 1
fi

# Enable various ftrace debugging events for USB

tracefs=/sys/kernel/tracing

 

if [ -d $tracefs ]; then

  cd $tracefs

 

  # global kprobe events

  echo 'p:usb_gadget/p_config_usb_cfg_link_0 config_usb_cfg_link cfg=+0(+0($arg1)):string func=+0(+0($arg2)):string' >> kprobe_events

  echo 'r:usb_gadget/r_config_usb_cfg_link_0 config_usb_cfg_link ret=$retval:s32' >> kprobe_events

  echo 'p:usb_gadget/p_config_usb_cfg_unlink_0 config_usb_cfg_unlink cfg=+0(+0($arg1)):string func=+0(+0($arg2)):string' >> kprobe_events

  echo 'p:usb_gadget/p_gadget_dev_desc_UDC_store_0 gadget_dev_desc_UDC_store udc=+0($arg2):string' >> kprobe_events

  echo 'r:usb_gadget/r_gadget_dev_desc_UDC_store_0 gadget_dev_desc_UDC_store ret=$retval:s32' >> kprobe_events

  echo 'p:usb_gadget/p_unregister_gadget_item_0 unregister_gadget_item gadget=+0(+0($arg1)):string' >> kprobe_events

 

  # usb instances

  mkdir instances/usb

  cd instances/usb

 

  # dwc3

  echo 1 > events/dwc3/dwc3_complete_trb/enable

  echo 1 > events/dwc3/dwc3_ctrl_req/enable

  echo 1 > events/dwc3/dwc3_ep_dequeue/enable

  echo 1 > events/dwc3/dwc3_ep_queue/enable

  echo 1 > events/dwc3/dwc3_gadget_ep_cmd/enable

  echo 1 > events/dwc3/dwc3_gadget_ep_disable/enable

  echo 1 > events/dwc3/dwc3_gadget_ep_enable/enable

  echo 1 > events/dwc3/dwc3_gadget_giveback/enable

  echo 1 > events/dwc3/dwc3_prepare_trb/enable

  echo 1 > events/dwc3/dwc3_event/enable

  echo 1 > events/dwc3/dwc3_alloc_request/enable

  echo 1 > events/dwc3/dwc3_free_request/enable

  echo 1 > events/dwc3/dwc3_gadget_generic_cmd/enable

 

  # ucsi

  echo 1 > events/ucsi/ucsi_connector_change/enable

  echo 1 > events/ucsi/ucsi_reset_ppm/enable

  echo 1 > events/ucsi/ucsi_run_command/enable

 

  # USB gadget

  echo 1 > events/gadget/usb_gadget_disconnect/enable

  echo 1 > events/gadget/usb_gadget_connect/enable

  echo 1 > events/gadget/usb_gadget_vbus_draw/enable

 

  # usb instance kprobe events

  echo 1 > events/usb_gadget/enable

 

  #DWC3 core runtime

  echo 'name~"a600000.*"' > events/rpm/filter

  echo 1 > events/rpm/rpm_resume/enable

  echo 1 > events/rpm/rpm_suspend/enable

  echo 1 > events/rpm/rpm_return_int/enable

 

  #xhci

  mkdir $tracefs/instances/usb_xhci

  echo 1 > $tracefs/instances/usb_xhci/events/xhci-hcd/enable

 

  echo 1 > $tracefs/instances/usb_xhci/tracing_on

  echo 1 > tracing_on

 

  #dwc3_readl_writel

  mkdir $tracefs/instances/dwc3_rw_traces

  echo 1 > $tracefs/instances/dwc3_rw_traces/events/dwc3/dwc3_readl/enable

  echo 1 > $tracefs/instances/dwc3_rw_traces/events/dwc3/dwc3_writel/enable

fi
