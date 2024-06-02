dnl##                                               -*- Autoconf -*-
dnl## Process this file with autoconf to produce configure.
dnl## In general, the safest way to proceed is to run ./autogen.sh
dnl## ^ Actually the real safest way is just to run `autoreconf` 
dnl## with your favorite flags, but whatever...

AC_PREREQ([2.69])dnl

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

AM_INIT_AUTOMAKE([gnits subdir-objects -Wall -Wno-obsolete -Wno-cross])
AM_MAINTAINER_MODE

AC_ARG_WITH([zlib],
  [AS_HELP_STRING([--with-zlib],
    [include classes for streaming compressed data in and out @<:@default=check@:>@])],
  [],[with_zlib=check])dnl

AC_ARG_WITH([protoc],
  [AS_HELP_STRING([--with-protoc=COMMAND],
    [use the given protoc command instead of building a new one when building tests (useful for cross-compiling)])],
  [],[with_protoc=no])dnl

# Checks for programs.
AC_USE_SYSTEM_EXTENSIONS
AM_PROG_AR
AS_IF([test "x${AR}" = "x"],[
  test -z "${AR}" || unset AR
  ## might want to switch around these checks...
  AS_IF([test "x${ac_cv_prog_AR}" = "x"],[
    test -z "${ac_cv_prog_AR}" || unset ac_cv_prog_AR
    m4_ifdef([AC_PROG_AR],[
      AC_PROG_AR
    ],[
      test -x "`which ar`" && echo "which ar? `which ar`"
    ])
  ])
],[
  test -n "${AR}" && test -x "${AR}" && export AR
])
AS_IF([test "x${AWK}" = "x"],[
  test -z "${AWK}"
  AC_PROG_AWK
],[
  test -n "${AWK}" && test -x "${AWK}" && export AWK
  AC_SUBST([AWK])
])
AS_IF([test "x${CC}" = "x"],[
  test -z "${CC}"
  AC_PROG_CC
],[
  test -n "${CC}" && test -x "${CC}" && export CC
  AC_SUBST([CC])
])
AC_PROG_CXX
AC_LANG([C++])
AS_IF([test "x${CPP}" = "x"],[
  test -z "${CPP}"
  AC_PROG_CPP
])
AS_IF([test "x${INSTALL}" = "x"],[
  test -z "${INSTALL}"
  AC_PROG_INSTALL
  AM_PROG_INSTALL_STRIP
],[
  test -n "${INSTALL}" && test -x "${INSTALL}" && export INSTALL
  AC_SUBST([INSTALL])
])
AC_PROG_LN_S
AS_IF([test "x${MAKE}" = "x"],[
  test -z "${MAKE}"
  AC_PATH_PROGS([MAKE],[make gmake gnumake remake])
  AC_PROG_MAKE_SET
],[
  test -n "${MAKE}" && test -x "${MAKE}" && export MAKE
  AC_SUBST([MAKE])
])
ACX_USE_SYSTEM_EXTENSIONS
AM_CONDITIONAL([GCC],[test "${GCC}" = yes]) # let Makefile know we are gcc

# test_util.cc takes forever to compile with GCC & optimization turned on.
AC_MSG_CHECKING([C++ compiler flags...])
AS_IF([test "x${ac_cv_env_CXXFLAGS_set}" = "x"],[
  AS_IF([test "${GCC}" = "yes"],[
    PROTOBUF_OPT_FLAG="-O2"
    CXXFLAGS="${CXXFLAGS} -g -std=gnu++11"
  ])dnl

  # Protocol Buffers contains several checks intended to be used only
  # for debugging and which might hurt performance. Most users are probably
  # end users who do NOT want these checks, so add -DNDEBUG by default.
  CXXFLAGS="${CXXFLAGS} -DNDEBUG"

  AC_MSG_RESULT([use default: ${PROTOBUF_OPT_FLAG} ${CXXFLAGS}])
],[
  AC_MSG_RESULT([use user-supplied: ${CXXFLAGS}])
])dnl

AC_SUBST([PROTOBUF_OPT_FLAG])dnl

ACX_CHECK_SUNCC

# Have to do libtool after SUNCC, otherwise it "helpfully" adds Crun Cstd
# to the link:
LT_INIT([win32-dll])dnl
LT_LANG([C])dnl
LT_LANG([C++])dnl
LT_LANG([Java])dnl
dnl# temporarily set this while I update everything libtool-related:
LT_PREREQ([2.4.6])dnl

AS_IF([test "x${RANLIB}" = "x"],[
  test -z "${RANLIB}"
  AC_PROG_RANLIB
],[
  test -n "${RANLIB}" && test -x "${RANLIB}" && export RANLIB
  AC_SUBST([RANLIB])dnl
])dnl

# Checks for header files.
AC_HEADER_DIRENT
AC_HEADER_STDBOOL dnl# Also "_CHECK"s it
AC_HEADER_SYS_WAIT
AC_CHECK_HEADERS([fcntl.h float.h limits.h locale.h stdio.h sys/param.h])dnl

if test "x${acl_cv_wp}" = "x"; then
  test -z "${acl_cv_wp}" && export acl_cv_wp='-Wp,'
fi
AC_SUBST([acl_cv_wp])dnl

if test "x${ac_cv_header_inttypes_h}" = "x"; then
  test -z "${ac_cv_header_inttypes_h}" || unset ac_cv_header_inttypes_h
  AC_CHECK_HEADERS([inttypes.h])
fi
if test "x${ac_cv_header_stdint_h}" = "x"; then
  test -z "${ac_cv_header_stdint_h}" || unset ac_cv_header_stdint_h
  AC_CHECK_HEADERS([stdint.h])
fi
if test "x${ac_cv_header_unistd_h}" = "x"; then
  test -z "${ac_cv_header_unistd_h}" || unset ac_cv_header_unistd_h
  AC_CHECK_HEADERS([unistd.h])
fi

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES
AC_C_VOLATILE
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
AC_CHECK_TYPES([ptrdiff_t])dnl
AC_TYPE_SIGNAL

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_FUNC_SELECT_ARGTYPES
AC_FUNC_STRTOD
AC_CHECK_FUNCS([dup2 ftruncate localeconv memmove memset mkdir realpath \
                select setlocale strchr strdup strerror strpbrk strtol \
                strtoul strtoull])dnl

# Check for zlib.
HAVE_ZLIB=0
AS_IF([test "x${with_zlib}" != "xno"],[
  # First check the zlib header version.
  AC_CHECK_HEADERS([zlib.h])
  AC_MSG_CHECKING([zlib version])
  AC_COMPILE_IFELSE([AC_LANG_SOURCE([
    AC_LANG_PROGRAM([[
        #include <zlib.h>
        #if !defined(ZLIB_VERNUM) || (ZLIB_VERNUM < 0x1204)
        # error "zlib version too old"
        #endif /* older than 1.2.0.4 */
        ]],[])])],[
    AC_MSG_RESULT([ok (1.2.0.4 or later)])

    # Also need to add -lz to the linker flags and make sure this succeeds.
    AC_CHECK_LIB([z],[zlibVersion])
    AC_SEARCH_LIBS([zlibVersion],[z],[
      AC_DEFINE([HAVE_ZLIB],[1],[Enable classes using zlib compression.])
      HAVE_ZLIB=1
    ],[
      AS_IF([test "x${with_zlib}" != "xcheck"],[
        AC_MSG_FAILURE([--with-zlib was given, but no working zlib library was found])
      ])dnl
    ])dnl
  ],[
    AS_IF([test "x${with_zlib}" = "xcheck"],[
      AC_MSG_RESULT([headers missing or too old (requires 1.2.0.4)])
    ],[
      AC_MSG_FAILURE([--with-zlib was given, but zlib headers were not present or were too old (requires 1.2.0.4)])
    ])dnl
  ])dnl
])dnl# end outmost zlib conditional
  ## (need this extra line with spaces before the comment here)
AM_CONDITIONAL([HAVE_ZLIB],[test ${HAVE_ZLIB} = 1])dnl

dnl# Check for grep before using it.
AC_DEFUN([AC_REQUIRE_GREPS],[
  AC_REQUIRE([AC_PROG_GREP])dnl
  AC_REQUIRE([AC_PROG_EGREP])dnl
  AC_REQUIRE([AC_PROG_FGREP])dnl
])dnl
AC_REQUIRE_GREPS

# Check for an external protoc.
AS_IF([test "x${with_protoc}" != "xno"],[
  PROTOC=${with_protoc}
  AS_IF([test "x${with_protoc}" = "xyes"],[
    # No argument given. Use system protoc.
    PROTOC=protoc
  ])
  AS_IF([echo "${PROTOC}" | grep -q '^@<:@^/@:>@.*/'],[
    # Does not start with a slash, but has a slash. So it is a relative
    # path (as opposed to an absolute path or an executable in ${PATH}).
    # Since it will actually be execed from the src directory, prefix with
    # the current dir. We also insert ${ac_top_build_prefix} in case this
    # is a nested package and --with-protoc was actually given on the outer
    # package's configure script.
    PROTOC=`pwd`/${ac_top_build_prefix}${PROTOC}
  ])
  AC_SUBST([PROTOC])dnl
])dnl
  ## (need this extra line with spaces before the comment here)
AM_CONDITIONAL([USE_EXTERNAL_PROTOC],[test "x${with_protoc}" != "xno"])dnl

AX_PTHREAD
AC_CXX_STL_HASH

# HACK: Make gtest's configure script pick up our CFLAGS and CXXFLAGS,
# since the flags added by ACX_CHECK_SUNCC must be used to compile gtest
# too.
export CFLAGS
export CXXFLAGS
AC_CONFIG_SUBDIRS([gtest])dnl

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
])dnl
AC_OUTPUT
