#Owned by DairyMan@Whirlpool
#
#Copyright GNU act.
include $(TOPDIR)/rules.mk

PKG_NAME:=world-zerotier
PKG_VERSION:=4.500
PKG_RELEASE:=1

PKG_MAINTAINER:=Created by DM/makefile by Cobia@whirlpool
include $(INCLUDE_DIR)/package.mk

define Package/world-zerotier
  SECTION:=utils
  CATEGORY:=ROOter
  SUBMENU:=Optional Applications
  DEPENDS:=+zerotier
  TITLE:=Install scripts for Zerotier
  PKGARCH:=all
endef

define Package/world-zerotier/description
  Install scripts for Zerotier
endef


define Build/Compile
endef

define Package/world-zerotier/install
	$(CP) ./files/* $(1)/
endef

$(eval $(call BuildPackage,world-zerotier))
