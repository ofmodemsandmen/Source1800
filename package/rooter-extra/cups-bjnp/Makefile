# 
# Copyright (C) 2010 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# 1d5a1588f3649ce7c5758cbea5a86900  cups-bjnp-2.0.3.tar.gz
# https://sourceforge.net/projects/cups-bjnp/files/latest/download
# c914b2fd9d8e26ce22f2df6244d9defeec31ee9a5360f723eecb3b00f2168500  ./cups-bjnp-2.0.3.tar.gz

include $(TOPDIR)/rules.mk

PKG_NAME:=cups-bjnp
PKG_VERSION:=2.0.3
PKG_RELEASE:=1

PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_URL:=http://www.ofmodemsandmen.com/download/
PKG_HASH:=c914b2fd9d8e26ce22f2df6244d9defeec31ee9a5360f723eecb3b00f2168500

PKG_BUILD_DEPENDS:=cups

include $(INCLUDE_DIR)/package.mk

define Package/cups-bjnp
  SECTION:=net
  CATEGORY:=Network
  TITLE:=BJNP protocol backend for CUPS
  URL:=http://sourceforge.net/projects/cups-bjnp/
  DEPENDS:=cups
  SUBMENU:=Printing
endef

define Package/cups-bjnp/description
CUPS backend for the canon printers using the proprietary USB over
IP BJNP protocol. This backend allows Cups to print over the network
to a Canon printer. It currently supports Cups 1.2 and Cups 1.3 and
is designed by reverse engineering.
endef

CONFIGURE_ARGS += --with-cupsbackenddir=$(STAGING_DIR)/usr/include/cups

TARGET_CFLAGS+=-Wl,-rpath-link=$(STAGING_DIR)/usr/lib

define Package/cups-bjnp/install
	$(INSTALL_DIR) $(1)/usr/lib/cups/backend
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/bjnp $(1)/usr/lib/cups/backend
endef


$(eval $(call BuildPackage,cups-bjnp))
