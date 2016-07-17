include vars.mk

PKG ?= nopackage
VER ?= 9.9.9

ifndef XZ
override XZ = xz
endif

CFG_OPTS := $(CFG_$(PKG))

SRCDIST := $(PKG)-$(VER).tar.$(XZ)
DIR := $(PKG)-$(VER)

gnu.org=http://ftp.gnu.org/gnu

$(SRCDIST): URL=$(gnu.org)/$(PKG)
$(SRCDIST):
	$(download-gnu)

dist:
	mkdir -p $@

.PHONY: build install package clean

$(DIR)/Makefile: $(DIR)/Makefile.in | $(DIR)
	cd $(DIR) && ./configure --prefix=$(PREFIX) $(CFG_OPTS)

build: $(DIR) $(DIR)/Makefile
	$(MAKE) -C $<

install: $(DIR) build
	$(MAKE) -C $< install

dist/$(PKG)-$(VER).tar.xz: $(DIR)/Makefile | $(DIR) dist
	$(MAKE) -C $(DIR) dist-xz
	@mv -v $(DIR)/$(@F) $@

package: dist/$(PKG)-$(VER).tar.xz

clean:
	rm -rf $(DIR)

