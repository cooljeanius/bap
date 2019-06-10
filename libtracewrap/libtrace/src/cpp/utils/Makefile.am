## automake Makefile for libtrace utilities

AM_CXXFLAGS = ${acl_cv_wp}-I../pb ${acl_cv_wp}-I.. \
  ${acl_cv_wp}-I@LIBTRACE_DIR@/src/common \
  ${acl_cv_wp}-I@LIBTRACE_DIR@/protobuf/src
AM_CXXFLAGS += -m32

utils_LDADD = ../libtrace.a @LIBTRACE_DIR@/protobuf/src/.libs/libprotobuf.a -lpthread

bin_PROGRAMS = readtrace copytrace
readtrace_SOURCES = readtrace.cpp
readtrace_LDADD = $(utils_LDADD)
copytrace_SOURCES = copytrace.cpp
copytrace_LDADD = $(utils_LDADD)

# Do NOT auto-link LIBS coming from autoconf, because we might not have
# 32-bit equivalents!
LIBS =

DISTCLEANFILES = .DS_Store

distclean-local:
	rm -rf .deps || rmdir .deps
.PHONY: distclean-local
