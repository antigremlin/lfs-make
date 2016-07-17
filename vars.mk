PREFIX=/tools
gnu.org=http://ftp.gnu.org/gnu

define download-md5=
curl -fLO $(URL)/$@
@echo -n "md5sum: "
@grep $@ MD5SUMS | md5sum -c -
endef

define download-gnu=
curl -fLO $(URL)/$@
curl -fLO $(URL)/$@.sig
gpg --verify $@.sig
endef

%: %.tar.gz
	tar -xf $<

%: %.tar.bz2
	tar -xf $<

%: %.tar.xz
	tar -xf $<

