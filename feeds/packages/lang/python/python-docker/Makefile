include $(TOPDIR)/rules.mk

PKG_NAME:=python-docker
PKG_VERSION:=6.1.3
PKG_RELEASE:=1

PYPI_NAME:=docker
PKG_HASH:=aa6d17830045ba5ef0168d5eaa34d37beeb113948c413affe1d5991fc11f9a20

PKG_MAINTAINER:=Javier Marcet <javier@marcet.info>
PKG_LICENSE:=Apache-2.0
PKG_LICENSE_FILES:=LICENSE

PKG_BUILD_DEPENDS:=python-setuptools-scm/host

include ../pypi.mk
include $(INCLUDE_DIR)/package.mk
include ../python3-package.mk

define Package/python3-docker
  SECTION:=lang
  CATEGORY:=Languages
  SUBMENU:=Python
  TITLE:=A Python library for the Docker Engine API
  URL:=https://github.com/docker/docker-py
  DEPENDS:=\
	  +python3-light +python3-distutils +python3-logging \
	  +python3-openssl +python3-packaging +python3-paramiko +python3-six \
	  +python3-requests +python3-urllib3 +python3-websocket-client
endef

define Package/python3-docker/description
  A Python library for the Docker Engine API. It lets you do anything the
  docker command does, but from within Python apps – run containers manage
  containers, manage Swarms, etc.
endef

$(eval $(call Py3Package,python3-docker))
$(eval $(call BuildPackage,python3-docker))
$(eval $(call BuildPackage,python3-docker-src))
