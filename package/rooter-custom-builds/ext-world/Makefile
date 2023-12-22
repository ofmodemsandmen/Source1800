#Owned by DairyMan@Whirlpool
#
#Copyright GNU act.
include $(TOPDIR)/rules.mk

PKG_NAME:=ext-world
PKG_VERSION:=1.000
PKG_RELEASE:=1

PKG_MAINTAINER:=Created by DM/makefile by Cobia@whirlpool
include $(INCLUDE_DIR)/package.mk

define Package/ext-world
  SECTION:=utils
  CATEGORY:=ROOter
  DEPENDS:=+luci +ext-rooter-basic +build-admin +ext-gps \
		+luci-app-ddns +ddns-scripts +pingtest +ext-netselect \
		+extramenu +ext-blockport +ext-domain +ext-blacklist \
		+luci-app-rootervpn +ext-wireguard \
		+bwmon +464xlat +webconsole +ext-basicmenu \
		+ext-theme +luci-theme-argon +ext-login \
		+ca-bundle +ca-certificates \
		+arc-storage \
		+luci-app-sqm +kmod-sched-cake +luci-app-nft-qos \
		+ext-command +ext-speedtest \
		+openvpn-easy-rsa +openvpn-openssl \
		+ext-extra +luci-app-hotspot +luci-app-guestwifi \
		+usbmuxd +libusbmuxd-utils +libimobiledevice-utils +kmod-usb-net-ipheth \
		++luci-ssl +usbutils +openssl-util +irqbalance \
		+wget +luci-app-vpnbypass +coreutils-base64 \
		+ext-selectisp +ext-wizard +ext-ota +world-zerotier
  TITLE:=ROOter support for World routers
  PKGARCH:=all
endef

define Package/ext-world/description
  Helper scripts to enable support for World routers
endef


define Build/Compile
endef

$(eval $(call BuildPackage,ext-world))
