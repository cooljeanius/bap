## automake Makefile for libtrace C++ sources

AM_CXXFLAGS = ${acl_cv_wp}-I./pb ${acl_cv_wp}-I@LIBTRACE_DIR@/src/common \
  ${acl_cv_wp}-I@LIBTRACE_DIR@/protobuf/src $(CXXFLAGS)

lib_LIBRARIES = libtrace.a
libtrace_a_SOURCES = pb/frame.piqi.pb.h pb/frame.piqi.pb.cc trace.container.cpp

# Do NOT auto-link LIBS coming from autoconf, because we might not have
# 32-bit equivalents!
LIBS =

SUBDIRS = . utils

DISTCLEANFILES = .DS_Store *~ pb/.DS_Store

distclean-local:
	rm -rf .deps || rmdir .deps
	rm -rf pb/.deps || rmdir pb/.deps
.PHONY: distclean-local
