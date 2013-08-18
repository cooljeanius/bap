#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libtrace],[1.0],[bap-dev@lists.andrew.cmu.edu])
AC_CONFIG_SRCDIR([src/cpp/trace.container.hpp])
AC_CONFIG_HEADERS([src/cpp/config.h])
AC_CONFIG_MACRO_DIR([m4])

AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS

AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
AM_MAINTAINER_MODE

AC_SUBST([LIBTRACE_DIR])
LIBTRACE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

AC_SUBST([INCDIRS])

# Checks for programs.
AM_PROG_AR
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
if test "x$RANLIB" = "x"; then
	test -z "$RANLIB"
	AC_PROG_RANLIB
else
	test ! -z "$RANLIB"
	export RANLIB
	AC_SUBST([RANLIB])
fi
AC_PROG_OCAML
AC_PATH_PROG([OPAM],[opam])

# Checks for libraries.
AC_CHECK_LIB([pthread],[pthread_create])

# Checks for header files.
AC_CHECK_HEADERS([stdio.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_HEADER_STDBOOL
AC_C_BIGENDIAN
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_TYPE_UINT64_T
AC_SYS_LARGEFILE
AC_FUNC_FSEEKO

# Checks for library functions.
AC_CHECK_FUNCS([memset])

AC_ARG_WITH([batteries],
            [AS_HELP_STRING([--with-batteries],
            [specify path to batteries (directory must actually exist)])],
            [with_batteries="$( cd $withval && pwd )"],
            [])

AS_IF([test "x$with_batteries" != x],
      [AC_CHECK_OCAML_MODULE([has_batteries],[batteries],[BatHashtbl],[$with_batteries])
       AS_IF([test "x$has_batteries" = "xno"],
             [AC_MSG_FAILURE([batteries not found in $with_batteries])],
             [AC_SUBST([BAT_DIR],[$with_batteries])])],
      [AC_MSG_WARN([You must specify the path to batteries using --with-batteries. This ought to be an error, but it has been changed to a warning to facilitate work on this configure script.])])

AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/cpp/Makefile
                 src/cpp/utils/Makefile
                 src/ocaml/Makefile
                 src/ocaml/utils/Makefile])
# Configure piqi
AC_CONFIG_SUBDIRS([piqi/piqi])
# Configure google protobuf
# Note: protobuf must be compiled for 32-bit because it is linked by
# pintraces code, which is 32-bit
AC_CONFIG_SUBDIRS([protobuf])
AC_OUTPUT
