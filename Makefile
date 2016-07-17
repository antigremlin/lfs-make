.DELETE_ON_ERROR:
include vars.mk

dist:
	mkdir -p dist

### bzip2

bzip2-1.0.6.tar.gz: URL=http://www.bzip.org/1.0.6
bzip2-1.0.6.tar.gz:
	$(download-md5)

.PHONY: install-bzip2 clean-bzip2
install-bzip2: bzip2-1.0.6
	$(MAKE) -C $<
	$(MAKE) -C $< PREFIX=$(PREFIX) install

clean-bzip2:
	rm -rf bzip2-1.0.6

### gettext

gettext-0.19.7.tar.xz: URL=$(gnu.org)/gettext
gettext-0.19.7.tar.xz:
	$(download-gnu)

.PHONY: install-gettext clean-gettext
install-gettext: gettext-0.19.7
	cd $</gettext-tools && EMACS=no ./configure --prefix=$(PREFIX) --disable-shared
	$(MAKE) -C $</gettext-tools/gnulib-lib
	$(MAKE) -C $</gettext-tools/intl pluralx.c
	$(MAKE) -C $</gettext-tools/src msgfmt msgmerge xgettext
	@cd $</gettext-tools && cp -v src/{msgfmt,msgmerge,xgettext} /tools/bin 

clean-gettext:
	rm -rf gettext-0.19.7

### simple non-GNU packages

export URL_file = ftp://ftp.astron.com/pub/file
export URL_util-linux = https://www.kernel.org/pub/linux/utils/util-linux/v2.27
export URL_xz = http://tukaani.org/xz

export CFG_util-linux = --without-python
export CFG_util-linux += --disable-makeinstall-chown
export CFG_util-linux += --without-systemdsystemunitdir
export CFG_util-linux += PKG_CONFIG=""

include _build-misc-file.mk
include _build-misc-util-linux.mk
include _build-misc-xz.mk

### simple GNU packages

export CFG_coreutils = --enable-install-program=hostname
export CFG_make = --without-guile

include _build-gnu-coreutils.mk
include _build-gnu-diffutils.mk
include _build-gnu-findutils.mk
include _build-gnu-gawk.mk
include _build-gnu-grep.mk
include _build-gnu-gzip.mk
include _build-gnu-m4.mk
include _build-gnu-make.mk
include _build-gnu-patch.mk
include _build-gnu-sed.mk
include _build-gnu-tar.mk
include _build-gnu-texinfo.mk

_build-misc-%.mk: misc-build.mk packages
	grep $* packages | (read p v z && m4 -D_PKG=$$p -D_VER=$$v -D_XZ=$$z misc-targets.m4 > $@)
_build-gnu-%.mk: gnu-build.mk packages
	grep $* packages | (read p v z && m4 -D_PKG=$$p -D_VER=$$v -D_XZ=$$z gnu-targets.m4 > $@)

gnu-build.mk:
packages:

