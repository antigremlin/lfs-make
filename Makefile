.DELETE_ON_ERROR:
PREFIX=/tools

dist:
	mkdir dist

define download-md5=
@curl -fLO $(URL)/$@
@echo -n "md5sum: "
@grep $@ MD5SUMS | md5sum -c -
endef

bzip2-1.0.6.tar.gz: URL=http://www.bzip.org/1.0.6
bzip2-1.0.6.tar.gz:
	$(download-md5)

.PHONY: install-bzip2 clean-bzip2
install-bzip2: bzip2-1.0.6
	$(MAKE) -C $<
	$(MAKE) -C $< PREFIX=$(PREFIX) install

clean-bzip2:
	rm -rf bzip2-1.0.6

gnu.org=http://ftp.gnu.org/gnu
define download-gnu=
curl -fLO $(URL)/$@
curl -fLO $(URL)/$@.sig
gpg --verify $.sig
endef

coreutils-8.25.tar.xz: URL=$(gnu.org)/coreutils
coreutils-8.25.tar.xz:
	$(download-gnu)

.PHONY: install-coreutils clean-coreutils
install-coreutils: coreutils-8.25
	cd $< && ./configure --prefix=$(PREFIX) --enable-install-program=hostname
	$(MAKE) -C $<
	$(MAKE) -C $< install

clean-coreutils:
	rm -rf coreutils-8.25

diffutils-3.3.tar.xz: URL=$(gnu.org)/diffutils
diffutils-3.3.tar.xz:
	$(download-gnu)

.PHONY: install-diffutils clean-diffutils
install-diffutils: diffutils-3.3
	cd $< && ./configure --prefix=$(PREFIX)
	$(MAKE) -C $<
	$(MAKE) -C $< install

clean-diffutils:
	rm -rf diffutils-3.3

file-5.25.tar.gz: URL=ftp://ftp.astron.com/pub/file
file-5.25.tar.gz:
	$(download-md5)

.PHONY: install-file dist-file clean-file
install-file: file-5.25
	cd $< && ./configure --prefix=$(PREFIX)
	$(MAKE) -C $<
	$(MAKE) -C $< install

dist/file-5.25.tar.xz: file-5.25 file-5.25/Makefile | dist
	$(MAKE) -C $< dist-xz
	@mv -v $</$(@F) $@

dist-file: dist/file-5.25.tar.xz

clean-file:
	rm -rf file-5.25

findutils-4.6.0.tar.gz: URL=$(gnu.org)/findutils
findutils-4.6.0.tar.gz:
	$(download-gnu)

%: %.tar.gz
	tar -xf $<

%: %.tar.bz
	tar -xf $<

%: %.tar.xz
	tar -xf $<

