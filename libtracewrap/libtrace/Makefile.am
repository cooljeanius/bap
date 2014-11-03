## automake Makefile for the libtrace part of the libtracewrap that is
## distributed with bap

SUBDIRS = piqi protobuf src

ACLOCAL_AMFLAGS = -I m4 --install

noinst_SCRIPTS = autogen.sh

DISTCLEANFILES = config.status .DS_Store

distclean-local:
	rm -rf autom4te.cache || rmdir autom4te.cache

MAINTAINERCLEANFILES = autoscan.log configure.scan

nodist_noinst_DATA = @MAINT@ configure.scan

configure.scan:
	autoscan || touch $@
