dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([piqi],[0.6.0],[http://groups.google.com/group/piqi])
AC_CONFIG_SRCDIR([piqilib/piqi_c_impl.c])
AC_CONFIG_HEADERS([config.h])

AC_CANONICAL_TARGET

AM_DEP_TRACK
AM_MAINTAINER_MODE

# Checks for programs.
AC_PROG_CXX
if test "x$CC" = "x"; then
	test -z "$CC"
	AC_PROG_CC
else
	test ! -z "$CC"
	export CC
	AC_SUBST([CC])
fi
if test "x$CPP" = "x"; then
	test -z "$CPP"
	AC_PROG_CPP
fi
AC_PROG_INSTALL
AM_PROG_INSTALL_STRIP
AM_PROG_LEX
AC_PROG_YACC
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_ERLANG_PATH_ERL
AC_ERLANG_PATH_ERLC

AC_CHECK_PROG([OCAMLC],[ocamlc],[ocamlc],[no])
if test "$OCAMLC" = no ; then
	AC_MSG_ERROR([Cannot find ocamlc.])
fi
AC_SUBST([OCAMLC])

AC_CHECK_PROG([OCAMLFIND],[ocamlfind],[ocamlfind])
if test "$OCAMLFIND" = no ; then
	AC_MSG_WARN([Cannot find ocamlfind.])
else
	OCAML_LIBDIR=`ocamlfind printconf destdir`
	export OCAML_LIBDIR
	AC_SUBST([OCAML_LIBDIR])
fi

# Checks for libraries.
# FIXME: Replace `main' with a function in `-lprotobuf':
AC_CHECK_LIB([protobuf],[main])
# FIXME: Replace `main' with a function in `-lprotoc':
AC_CHECK_LIB([protoc],[main])
AC_CHECK_LIB([pthread],[pthread_create])

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h stdio.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_TYPE_UINT64_T

# Checks for library functions.
AC_CHECK_FUNCS([strtoull])

AC_CONFIG_FILES([configure.sh])
AC_OUTPUT

# run the old configure script, too
echo "sh ./configure.sh"
sh ./configure.sh
