dnl##                                               -*- Autoconf -*-
dnl## Process this file with autoconf to produce configure.
dnl## In general, the safest way to proceed is to run ./autogen.sh
dnl## ^ Actually the real safest way is just to run `autoreconf` 
dnl## with your favorite flags, but whatever...

AC_PREREQ([2.69])

# Note:  If you change the version, you must also update it in:
# * java/pom.xml
# * python/setup.py
# * src/google/protobuf/stubs/common.h
# * src/Makefile.am (Update -version-info for LDFLAGS if needed)
#
# In the SVN trunk, the version should always be the next up release
# version with the "-pre" suffix. (We used to use "-SNAPSHOT" which pushed
# the size of one file name in the dist tarfile over the 99-char limit.)

AC_INIT([Protocol Buffers],[2.4.1],[protobuf@googlegroups.com],[protobuf])

AC_CONFIG_SRCDIR([src/google/protobuf/message.cc])
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_MACRO_DIR([m4])

# autoconf's default CXXFLAGS are often "-g -O2". These are not necessarily
# the best choice for libprotobuf.
AS_IF([test "x${ac_cv_env_CFLAGS_set}" = "x"],
      [CFLAGS=""])
AS_IF([test "x${ac_cv_env_CXXFLAGS_set}" = "x"],
      [CXXFLAGS=""])

AC_CANONICAL_TARGET

AM_INIT_AUTOMAKE([gnits subdir-objects -Wall])
AM_MAINTAINER_MODE

AC_ARG_WITH([zlib],
  [AS_HELP_STRING([--with-zlib],
    [include classes for streaming compressed data in and out @<:@default=check@:>@])],
  [],[with_zlib=check])

AC_ARG_WITH([protoc],
  [AS_HELP_STRING([--with-protoc=COMMAND],
    [use the given protoc command instead of building a new one when building tests (useful for cross-compiling)])],
  [],[with_protoc=no])

# Checks for programs.
AC_USE_SYSTEM_EXTENSIONS
AM_PROG_AR
if test "x${AWK}" = "x"; then
	test -z "${AWK}"
	AC_PROG_AWK
else
	test ! -z "${AWK}" && export AWK
	AC_SUBST([AWK])
fi
if test "x${CC}" = "x"; then
	test -z "${CC}"
	AC_PROG_CC
else
	test ! -z "${CC}" && export CC
	AC_SUBST([CC])
fi
AC_PROG_CXX
AC_LANG([C++])
if test "x${CPP}" = "x"; then
	test -z "${CPP}"
	AC_PROG_CPP
fi
if test "x${INSTALL}" = "x"; then
	test -z "${INSTALL}"
	AC_PROG_INSTALL
	AM_PROG_INSTALL_STRIP
else
	test ! -z "${INSTALL}" && export INSTALL
	AC_SUBST([INSTALL])
fi
AC_PROG_LN_S
if test "x${MAKE}" = "x"; then
	test -z "${MAKE}"
	AC_PATH_PROG([MAKE],[make gmake gnumake])
	AC_PROG_MAKE_SET
else
	test ! -z "${MAKE}" && export MAKE
	AC_SUBST([MAKE])
fi
ACX_USE_SYSTEM_EXTENSIONS
AM_CONDITIONAL([GCC],[test "${GCC}" = yes]) # let Makefile know we are gcc
AC_PROG_GCC_TRADITIONAL

# test_util.cc takes forever to compile with GCC & optimization turned on.
AC_MSG_CHECKING([C++ compiler flags...])
AS_IF([test "x${ac_cv_env_CXXFLAGS_set}" = "x"],[
  AS_IF([test "${GCC}" = "yes"],[
    PROTOBUF_OPT_FLAG="-O2"
    CXXFLAGS="${CXXFLAGS} -g"
  ])

  # Protocol Buffers contains several checks intended to be used only
  # for debugging and which might hurt performance. Most users are probably
  # end users who do NOT want these checks, so add -DNDEBUG by default.
  CXXFLAGS="${CXXFLAGS} -DNDEBUG"

  AC_MSG_RESULT([use default: ${PROTOBUF_OPT_FLAG} ${CXXFLAGS}])
],[
  AC_MSG_RESULT([use user-supplied: ${CXXFLAGS}])
])

AC_SUBST([PROTOBUF_OPT_FLAG])

ACX_CHECK_SUNCC

# Have to do libtool after SUNCC, otherwise it "helpfully" adds Crun Cstd
# to the link
LT_INIT([win32-dll])
LT_LANG([C])
LT_LANG([C++])
LT_LANG([Java])

if test "x${RANLIB}" = "x"; then
	test -z "${RANLIB}"
	AC_PROG_RANLIB
else
	test ! -z "${RANLIB}" && export RANLIB
	AC_SUBST([RANLIB])
fi

# Checks for header files.
AC_HEADER_STDBOOL dnl# Also "_CHECK"s it
AC_CHECK_HEADERS([fcntl.h float.h limits.h locale.h stdio.h sys/param.h])

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_TYPES([ptrdiff_t])

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_FUNC_STRTOD
AC_CHECK_FUNCS([dup2 ftruncate localeconv memmove memset mkdir realpath \
                select setlocale strchr strdup strerror strpbrk strtol \
                strtoul strtoull])

# Check for zlib.
HAVE_ZLIB=0
AS_IF([test "${with_zlib}" != no],[
  # First check the zlib header version.
  AC_CHECK_HEADERS([zlib.h])
  AC_MSG_CHECKING([zlib version])
  AC_COMPILE_IFELSE([AC_LANG_SOURCE([
    AC_LANG_PROGRAM([[
        #include <zlib.h>
        #if !defined(ZLIB_VERNUM) || (ZLIB_VERNUM < 0x1204)
        # error zlib version too old
        #endif
        ]],[])])],[
    AC_MSG_RESULT([ok (1.2.0.4 or later)])

    # Also need to add -lz to the linker flags and make sure this succeeds.
    AC_CHECK_LIB([z],[zlibVersion])
    AC_SEARCH_LIBS([zlibVersion],[z],[
      AC_DEFINE([HAVE_ZLIB],[1],[Enable classes using zlib compression.])
      HAVE_ZLIB=1
    ],[
      AS_IF([test "${with_zlib}" != check],[
        AC_MSG_FAILURE([--with-zlib was given, but no working zlib library was found])
      ])
    ])
  ],[
    AS_IF([test "${with_zlib}" = check],[
      AC_MSG_RESULT([headers missing or too old (requires 1.2.0.4)])
    ],[
      AC_MSG_FAILURE([--with-zlib was given, but zlib headers were not present or were too old (requires 1.2.0.4)])
    ])
  ])
])
AM_CONDITIONAL([HAVE_ZLIB],[test ${HAVE_ZLIB} = 1])

AS_IF([test "${with_protoc}" != "no"], [
  PROTOC=$with_protoc
  AS_IF([test "${with_protoc}" = "yes"], [
    # No argument given. Use system protoc.
    PROTOC=protoc
  ])
  AS_IF([echo "${PROTOC}" | grep -q '^@<:@^/@:>@.*/'], [
    # Does not start with a slash, but has a slash. So it is a relative
    # path (as opposed to an absolute path or an executable in ${PATH}).
    # Since it will actually be execed from the src directory, prefix with
    # the current dir. We also insert ${ac_top_build_prefix} in case this
    # is a nested package and --with-protoc was actually given on the outer
    # package's configure script.
    PROTOC=`pwd`/${ac_top_build_prefix}${PROTOC}
  ])
  AC_SUBST([PROTOC])
])
AM_CONDITIONAL([USE_EXTERNAL_PROTOC],[test "${with_protoc}" != "no"])

AX_PTHREAD
AC_CXX_STL_HASH

# HACK: Make gtest's configure script pick up our CFLAGS and CXXFLAGS,
# since the flags added by ACX_CHECK_SUNCC must be used to compile gtest
# too.
export CFLAGS
export CXXFLAGS
AC_CONFIG_SUBDIRS([gtest])

AC_CONFIG_FILES([Makefile \
		 src/Makefile \
		 protobuf.pc \
		 protobuf-lite.pc])
AC_CONFIG_COMMANDS([bap-local],[
if test "$(cd ../.. && basename $(pwd))" = "libtracewrap"; then
  echo "CONFIGURED"
  touch ../../CONFIGURED
else
  echo "Not in subdirectory of libtracewrap, so never mind."
fi
])
AC_OUTPUT
