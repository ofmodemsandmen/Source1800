#Owned by DairyMan@Whirlpool
#
#Copyright GNU act.
include $(TOPDIR)/rules.mk

PKG_NAME:=ext-sky
PKG_VERSION:=1.000
PKG_RELEASE:=1

PKG_MAINTAINER:=Created by DM/makefile by Cobia@whirlpool
include $(INCLUDE_DIR)/package.mk

define Package/ext-sky
  SECTION:=utils
  CATEGORY:=ROOter
  DEPENDS:=+luci +ext-rooter-basic \
  		+ext-simplegps +bwallocate +extramenu +ext-simpin \
  		+ext-blacklist +ext-blockport +ext-domain +ext-texting \
  		+ext-zerotier +pingtest +webconsole \
		+luci-app-ddns +ddns-scripts \
		+luci-app-rootervpn +ext-wireguard \
		+webconsole +bwmon +464xlat \
		+ca-bundle +ca-certificates +libustream-wolfssl \
		+ext-command +ext-speedtest +luci-app-guestwifi \
		+openvpn-easy-rsa +openvpn-openssl \
		+ext-extra +luci-app-hotspot +luci-app-wol \
		+usbmuxd +libusbmuxd-utils +libimobiledevice-utils +kmod-usb-net-ipheth \
		+nano +picocom +wpad +wget +qfirehose 
  TITLE:=ROOter support w/o MWan3 for LteFix
  PKGARCH:=all
endef

define Package/ext-sky/description
  Helper scripts to enable ROOter support for LteFix
endef


define Build/Compile
endef

$(eval $(call BuildPackage,ext-sky))
