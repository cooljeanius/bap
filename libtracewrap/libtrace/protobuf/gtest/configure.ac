m4_include([m4/ax_pthread.m4])

dnl#                                               -*- Autoconf -*-
dnl# At this point, the Xcode project assumes the version string will be
dnl# three integers separated by periods and surrounded by square brackets
dnl# (e.g. "[1.0.1]"). It also asumes that there will not be any closing
dnl# parenthesis between \"\AC_INIT\(\" and the closing \"\)\"
dnl# including comments and strings.

AC_INIT([Google C++ Testing Framework],[1.4.0],[googletestframework@googlegroups.com],[gtest])

# Provide various options to initialize the Autoconf and configure processes.
AC_PREREQ([2.69])
AC_CONFIG_SRCDIR([./COPYING])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADERS([build-aux/config.h])
AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([scripts/gtest-config],[chmod +x scripts/gtest-config])

AC_CANONICAL_TARGET
AC_EXEEXT
AC_OBJEXT

# Initialize Automake with various options. We require at least v1.9, prevent
# pedantic complaints about package files, and enable various distribution
# targets.
AM_INIT_AUTOMAKE([1.9 dist-bzip2 dist-zip foreign subdir-objects -Wall])
AM_MAINTAINER_MODE

# Check for programs used in building Google Test.
AC_USE_SYSTEM_EXTENSIONS
AM_PROG_AR
if test "x$AWK" = "x"; then
	test -z "$AWK"
	AC_PROG_AWK
else
	test ! -z "$AWK"
	export AWK
	AC_SUBST([AWK])
fi
if test "x$CC" = "x"; then
	test -z "$CC"
	AC_PROG_CC
else
	test ! -z "$CC"
	export CC
	AC_SUBST([CC])
fi
AC_PROG_CXX
AC_LANG([C++])
if test "x$CPP" = "x"; then
	test -z "$CPP"
	AC_PROG_CPP
fi
if test "x$INSTALL" = "x"; then
	test -z "$INSTALL"
	AC_PROG_INSTALL
	AM_PROG_INSTALL_STRIP
else
	test ! -z "$INSTALL"
	export INSTALL
	AC_SUBST([INSTALL])
fi
AC_PROG_LN_S
if test "x$MAKE" = "x"; then
	test -z "$MAKE"
	AC_PATH_PROG([MAKE],[make gmake gnumake])
	AC_PROG_MAKE_SET
else
	test ! -z "$MAKE"
	export MAKE
	AC_SUBST([MAKE])
fi
LT_INIT

if test "x$RANLIB" = "x"; then
	test -z "$RANLIB"
	AC_PROG_RANLIB
else
	test ! -z "$RANLIB"
	export RANLIB
	AC_SUBST([RANLIB])
fi

# TODO(chandlerc@google.com): Currently we aren't running the Python tests
# against the interpreter detected by AM_PATH_PYTHON, and so we condition
# HAVE_PYTHON by requiring "python" to be in the PATH, and that interpreter's
# version to be >= 2.3. This will allow the scripts to use a "/usr/bin/env"
# hashbang.
PYTHON=  # We *do not* allow the user to specify a python interpreter
AC_PATH_PROG([PYTHON],[python],[:])
AS_IF([test "$PYTHON" != ":"],
      [AM_PYTHON_CHECK_VERSION([$PYTHON],[2.3],[:],[PYTHON=":"])])
AM_CONDITIONAL([HAVE_PYTHON],[test "$PYTHON" != ":"])

# Check for pthreads.
AX_PTHREAD

# TODO(chandlerc@google.com) Check for the necessary system headers.
AC_CHECK_HEADERS([fcntl.h limits.h stddef.h stdio.h sys/time.h sys/timeb.h \
wchar.h wctype.h])

# TODO(chandlerc@google.com) Check the types, structures, and other compiler
# and architecture characteristics.
AC_CHECK_HEADER_STDBOOL
AC_C_BIGENDIAN
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_PID_T
AC_C_RESTRICT
AC_TYPE_SIZE_T
AC_CHECK_TYPES([ptrdiff_t])

# Checks for library functions.
AC_FUNC_FORK
AC_FUNC_MALLOC
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_FUNC_STRERROR_R
AC_CHECK_FUNCS([dup2 getcwd gettimeofday memmove memset mkdir munmap putenv \
regcomp rmdir setenv strcasecmp strchr strdup strerror strrchr strstr \
strtol strtoull])

# Output the generated files. No further autoconf macros may be used.
AC_OUTPUT
