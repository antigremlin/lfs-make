.PHONY: install-_PKG dist-_PKG clean-_PKG
install-_PKG:
	$(MAKE) -f gnu-build.mk PKG=_PKG VER=_VER XZ=_XZ install
dist-_PKG:
	$(MAKE) -f gnu-build.mk PKG=_PKG VER=_VER XZ=_XZ package
clean-_PKG:
	$(MAKE) -f gnu-build.mk PKG=_PKG VER=_VER XZ=_XZ clean
