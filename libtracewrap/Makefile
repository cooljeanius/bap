# $Id: Makefile.in 7216 2013-03-02 04:09:04Z edmcman $
# Wrapper to configure and build libtrace

.PHONY: default
default: all

%:
	$(MAKE) CONFIGURED
	$(MAKE) -C libtrace $@

CONFIGURED: libtrace/Makefile.am libtrace/configure.ac
	(cd libtrace && INCDIRS="" CPPFLAGS="-I/opt/local/include/ -I/private/var/root/.opam/system/lib/camlidl" CFLAGS=-m32 CXXFLAGS=-m32 ./configure --with-batteries=/var/root/bap/batteries/_build/src)
	touch CONFIGURED
