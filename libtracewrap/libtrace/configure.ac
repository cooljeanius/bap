dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([libtrace],[1.0],[bap-dev@lists.andrew.cmu.edu])
AC_CONFIG_SRCDIR([src/cpp/trace.container.hpp])
AC_CONFIG_HEADERS([src/cpp/config.h])
AC_CONFIG_MACRO_DIR([m4])dnl

AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS

AM_INIT_AUTOMAKE([gnits subdir-objects -Wall])dnl
AM_MAINTAINER_MODE

LIBTRACE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AC_SUBST([LIBTRACE_DIR])dnl

AS_IF([test "x${INCDIRS}" = "x"]
      [## actually just keep it empty for now:
       test -z "${INCDIRS}" && INCDIRS=""])dnl
AC_SUBST([INCDIRS])dnl

# Checks for programs.
AM_PROG_AR
AC_PROG_CXX
if test "x${CC}" = "x"; then
  test -z "${CC}"
  AC_PROG_CC
else
  test ! -z "${CC}" && export CC
  AC_SUBST([CC])
fi
if test "x${CPP}" = "x"; then
  test -z "${CPP}"
  AC_PROG_CPP
fi
if test "x${RANLIB}" = "x"; then
  test -z "${RANLIB}"
  AC_PROG_RANLIB
else
  test ! -z "${RANLIB}" && export RANLIB
  AC_SUBST([RANLIB])
fi
AC_PROG_OCAML
AC_PATH_PROG([OPAM],[opam])dnl

# Checks for libraries.
AC_CHECK_LIB([pthread],[pthread_create])dnl

# Checks for header files.
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
AC_CHECK_HEADERS([stdio.h])dnl

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_TYPE_UINT64_T
AC_SYS_LARGEFILE

# Checks for library functions.
AC_FUNC_FSEEKO
AC_CHECK_FUNCS([memset strtoull])dnl

# Batteries.
AC_ARG_WITH([batteries],
            [AS_HELP_STRING([--with-batteries],
            [specify path to batteries (directory must actually exist)])],
            [with_batteries="$( cd ${withval} && pwd )"],
            [AS_IF([test "x${ac_abs_top_srcdir}" != "x"],
              [AS_IF([test -d "${ac_abs_top_srcdir}/batteries"],
                [export with_batteries="${ac_abs_top_srcdir}/batteries"],
                [AS_IF([test -d ../../batteries],
                       [export with_batteries=../../batteries],
                       [AC_MSG_WARN([no default for batteries])])])],
              [AS_IF([test -d ../../batteries],
                     [export with_batteries=../../batteries],
                     [AC_MSG_WARN([no default dir for batteries])])])])dnl

AS_IF([test "x${with_batteries}" != "x"],
      [test -n "${with_batteries}"
       AC_CHECK_OCAML_MODULE([has_batteries],[batteries],[BatHashtbl],
                             [${with_batteries}])
       AS_IF([test "x${has_batteries}" = "xno"],
             [AC_MSG_WARN([batteries not found in ${with_batteries}; proceeding as if they were missing. This ought to be an error, but it has been changed to a warning to facilitate work on this configure script.])
              unset with_batteries],
             [AC_SUBST([BAT_DIR],[${with_batteries}])])],
      [AS_IF([test -z "${with_batteries}"],
             [AC_MSG_WARN([You must specify the path to batteries using --with-batteries. This ought to be an error, but it has been changed to a warning to facilitate work on this configure script.])])])dnl

# Output.
AC_CONFIG_FILES([Makefile
                 src/Makefile
                 src/cpp/Makefile
                 src/cpp/utils/Makefile
                 src/ocaml/Makefile
                 src/ocaml/utils/Makefile])
# Configure piqi now:
AC_CONFIG_SUBDIRS([piqi/piqi])
# Configure google protobuf next.
# Note: protobuf must be compiled for 32-bit because it is linked by
# pintraces code, which is 32-bit.
AC_CONFIG_SUBDIRS([protobuf])
AC_CONFIG_COMMANDS([bap-local],[
if test "$(cd .. && basename $(pwd))" = "libtracewrap"; then
  echo "CONFIGURED"
  touch ../CONFIGURED
else
  echo "Not in subdirectory of libtracewrap, so never mind."
fi
])dnl
AC_OUTPUT
