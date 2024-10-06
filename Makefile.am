ACLOCAL_AMFLAGS = -I m4

if BUILD_TEST
  XBUILD_SUB_TEST = third_party test
endif

SUBDIRS = src $(XBUILD_SUB_TEST)

distcleancheck:
	@:

distclean-local:
	@:



# i know this isn't the right way to do this... but it's how i've been
# occasionally making .pkg files to install, now documented/automated
# to make life easier.
DEBREV=2
DEBVERSION=$(PACKAGE_VERSION)-$(DEBREV)
DEBNAME=$(PACKAGE_TARNAME)_$(DEBVERSION)
DEBFILE=$(abs_top_builddir)/$(DEBNAME).deb
DPKGDIR=$(abs_top_builddir)/$(DEBNAME)
DEBDIR=$(DPKGDIR)/DEBIAN
DEBCTRL=$(DEBDIR)/control
DEBSIZE=$(DEBDIR)/.size
DEBARCH=$(DEBDIR)/.arch
DEBDEPS=$(DEBDIR)/.deps
DEBCTRL_DEPS=$(DEBSIZE) $(DEBARCH) $(DEBDEPS)

.PHONY: dpkg
dpkg: $(DEBFILE)

$(DEBFILE): $(DEBCTRL)
	rm -f $(DEBCTRL_DEPS)
	dpkg-deb --build --root-owner-group $(DPKGDIR)
	rm -rf $(DPKGDIR)

$(DPKGDIR):
	./configure --prefix=/usr --sysconfdir=/etc --localstatedir=/var
	$(MAKE) clean
	$(MAKE) all
	$(MAKE) DESTDIR=$@ install-strip

$(DEBDIR): $(DPKGDIR)
	$(MKDIR_P) $@

$(DEBSIZE): $(DEBDIR)
	du -s $(DPKGDIR) | awk '{print $$1}' > $@

$(DEBARCH): $(DEBDIR)
	dpkg-architecture --query DEB_HOST_ARCH > $@

$(DEBDEPS): $(DEBDIR)
	$(srcdir)/debian/get_deps $(DPKGDIR) > $(DEBDIR)/.tmp
	awk -F": " '/^pkgs:/ {print $$2}' $(DEBDIR)/.tmp > $@
	rm -f $(DEBDIR)/.tmp

$(DEBCTRL): $(DEBCTRL_DEPS)
	cat $(srcdir)/debian/control | sed \
	    -e 's|__version__|$(DEBVERSION)|' \
	    -e "s|__size__|$$(cat $(DEBDIR)/.size)|" \
	    -e "s|__arch__|$$(cat $(DEBDIR)/.arch)|" \
	    -e "s|__deplibs__|$$(cat $(DEBDIR)/.deps)|" \
	    > $@
