# Owned and copyright BitBlaze, 2007. All rights reserved.
# Do not copy, disclose, or distribute without explicit written
# permission.
# (Oops)

#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Bap],[0.7],[bap-dev@lists.andrew.cmu.edu])
AC_CONFIG_SRCDIR([libasmir/src/asm_program.c])
AC_CONFIG_HEADER([libasmir/config.h])
AC_CONFIG_MACRO_DIR([m4])

AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS

AB_INIT
AM_INIT_AUTOMAKE([foreign subdir-objects -Wall])
GNOME_MAINTAINER_MODE_DEFINES

m4_include([./m4/ac_ocaml.m4])
m4_include([./m4/ac_prog_latex.m4])

# Checks for programs.
AM_PROG_AR
AM_PROG_AS
AC_PROG_CXX
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
if test "x$CPP" = "x"; then
	test -z "$CPP"
	AC_PROG_CPP
else
	test ! -z "$CPP"
	XORG_PROG_RAWCPP([])
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
AX_CHECK_GNU_MAKE
AM_PROG_LEX
AC_PROG_YACC
AC_PROG_OCAML([3.12.0])
AC_PROG_CAMLP4
AC_PROG_OCAMLFIND
AC_PROG_CAMLIDL
LT_INIT
if test "x$RANLIB" = "x"; then
	test -z "$RANLIB"
	AC_PROG_RANLIB
else
	test ! -z "$RANLIB"
	export RANLIB
	AC_SUBST([RANLIB])
fi
PKG_PROG_PKG_CONFIG

# Check for Z3
AC_ARG_WITH([z3],
            [AS_HELP_STRING([--with-z3],
              [location of Z3 library])],
            [with_z3=$withval],
            [with_z3=no])

# Save pre-z3 ldflags
OLDLDFLAGS=$LDFLAGS

AS_IF([test "x$with_z3" != "xno"],
     [
     LDFLAGS="$OLDLDFLAGS -L$with_z3/lib"
     AC_CHECK_LIB([z3], [Z3_mk_bvadd],
       [
        z3_dir=$with_z3
        with_z3=yes
        AC_DEFINE([HAVE_Z3_BINDINGS], [1], [Define to use Z3 bindings])
        ],
       [AC_MSG_FAILURE([z3 library not found])],
       [-lgmp -lgomp]
       )])

# Restore
LDFLAGS=$OLDLDFLAGS

rm -f solvers/makefile.inc
if `test "x$with_z3" = "xyes"`; then
   cat >>solvers/makefile.inc <<"EOF"
SOLVER_PPFLAGS=-D WITH_Z3_BINDINGS
SOLVER_CLIBS = z3stubs z3
EOF
echo "SOLVER_SOURCES = $z3_dir/ocaml/z3.ml" >>solvers/makefile.inc
echo "SOLVER_LIBDIRS = $z3_dir/lib" >>solvers/makefile.inc
echo "SOLVER_LDFLAGS = -fopenmp -Wl,-rpath=$z3_dir/lib" >> solvers/makefile.inc
else
   touch solvers/makefile.inc
fi

# Add -DAMD64 when needed
if test "$(uname -m)" == "x86_64";
   then export CFLAGS="$CFLAGS -DAMD64";
fi

# Check for PIN
PIN_HOME=${PIN_HOME:=$(pwd)/pin}
AC_CHECK_FILE([$PIN_HOME],
              [HAVE_PIN=true],
              [HAVE_PIN=false; AC_MSG_WARN([Pin not found. BAP pintraces will be unavailable.])])

AM_CONDITIONAL([HAVE_PIN],[test x$HAVE_PIN = xtrue])

# Conditionally build llvm
AC_MSG_CHECKING([llvm ocaml libraries])
AC_ARG_WITH([llvm],
            [AS_HELP_STRING([[--with-llvm=[=ARG]]],[use OCaml llvm package named ARG])],[LIBLLVM="$withval"],
             [LIBLLVM="check"])

AS_IF([test x$LIBLLVM = xno],
      [LLVM_PACKAGE=""],
      [AS_IF([test x$LIBLLVM = xyes -o x$LIBLLVM = xcheck],
             [AS_IF([ocamlfind query llvm >/dev/null 2>&1],
             [LLVM_PACKAGE="llvm"],
             [AS_IF([ocamlfind query llvm-3_1 >/dev/null 2>&1],
                    [LLVM_PACKAGE="llvm-3_1"],
                    [LLVM_PACKAGE=""])])],
             [AS_IF([ocamlfind query $LIBLLVM >/dev/null 2>&1],
                    [LLVM_PACKAGE="$LIBLLVM"],
                    [])])])

AS_IF([test \( x$LIBLLVM != xno -a x$LIBLLVM != xcheck \) -a x$LLVM_PACKAGE = x],
      [AC_MSG_FAILURE([--with-llvm specified but llvm was not found])],
      [])

AC_SUBST([LLVM_PACKAGE])

AS_IF([test x$LLVM_PACKAGE != x],[HAVE_LLVM_AC=yes],[HAVE_LLVM_AC=no])
AS_IF([test x$HAVE_LLVM_AC = xyes],
      [AC_MSG_RESULT([$HAVE_LLVM_AC ($LLVM_PACKAGE)])],
      [AC_MSG_RESULT([$HAVE_LLVM_AC])])
AC_SUBST([HAVE_LLVM_AC])


AS_IF([test "x$HAVE_LLVM_AC" = "xtrue"],
      [LLVM_PPFLAGS="-D WITH_LLVM"],
      [])
AC_SUBST([LLVM_PPFLAGS])

# Check for etags
AS_IF([which etags >/dev/null 2>&1],
      [HAVE_ETAGS=true],
      [HAVE_ETAGS=false; AC_MSG_WARN([ETAGS not found. BAP will not build tags.])])

AM_CONDITIONAL([HAVE_ETAGS],[test x$HAVE_ETAGS = xtrue])

# Checks for ocaml libraries
AC_MSG_CHECKING([for camomile])
ocamlfind query camomile >/dev/null 2>&1
if test $? != 0; then
   AC_MSG_RESULT([no])
   AC_MSG_ERROR([camomile ocaml package not found])
fi
AC_MSG_RESULT([yes])

VEX_DIR=`pwd`/'VEX'
VEX_VERSION=2201

# Checks for libraries.
AC_CHECK_LIB([bfd],[bfd_init],[],[AC_MSG_WARN([BFD library not found: This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])])
AC_CHECK_LIB([iberty],[xmalloc],[],[AC_MSG_WARN([libiberty not found: This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])])
AC_CHECK_LIB([pcre],[pcre_config],[],[AC_MSG_ERROR([PCRE library not found])])
# zlib is apparently needed by bfd
AC_CHECK_LIB([z],[inflate],[],[AC_MSG_ERROR([zlib library not found])])

# More checks for libraries
# FIXME: Replace `main' with a function in `-lasmir':
AC_CHECK_LIB([asmir],[main])
AC_CHECK_LIB([c],[printf])
AC_CHECK_LIB([dl],[dlopen])
AC_CHECK_LIB([m],[sqrt])
# FIXME: Replace `main' with a function in `-lopcodes':
AC_CHECK_LIB([opcodes],[main])
# FIXME: Replace `main' with a function in `-lprotobuf':
AC_CHECK_LIB([protobuf],[main])
AC_CHECK_LIB([pthread],[pthread_create])
# FIXME: Replace `main' with a function in `-lstdc++':
AC_CHECK_LIB([vex],[main])
# FIXME: Replace `main' with a function in `-lvex':
AC_CHECK_LIB([stdc++],[main])

AC_SUBST([VEX_DIR])

AC_SUBST([INCDIRS])

rm -f libasmir/makefile.inc
echo "VEX_DIR=${VEX_DIR}" >> libasmir/makefile.inc
echo "LIBASMIR_CXXFLAGS=-I${VEX_DIR}/pub -I`pwd`/src/include $CXXFLAGS" >> libasmir/makefile.inc
echo "LIBASMIR_LDFLAGS=-L${VEX_DIR} -L`pwd`/src $LDFLAGS" >> libasmir/makefile.inc
echo "LIBASMIR_LIBS=-lasmir -lvex -lbfd -ldl -liberty -lz" >> libasmir/makefile.inc
echo "CLIBS=asmir vex opcodes bfd z iberty stdc++" >> libasmir/makefile.inc
AC_SUBST([ASMIR_DIR])
ASMIR_DIR="`pwd`/libasmir"

AC_SUBST([BAP_DIR])
BAP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Checks for header files.
AC_CHECK_HEADERS([fcntl.h stdint.h stdio.h stdlib.h string.h unistd.h],[],
   [AC_MSG_ERROR([Standard headers missing])])
AC_CHECK_HEADERS([limits.h malloc.h mem/memory.h stddef.h sys/inttypes.h \
                  sys/socket.h])
AC_CHECK_HEADER([bfd.h],[],
   [AC_MSG_ERROR([You need BFD headers (e.g., libbfd-dev)])])
AC_CHECK_HEADER([pcre.h],[],
   [AC_MSG_ERROR([You need libpcre headers (e.g., libpcre3-dev)])])

# Checks for typedefs, structures, and compiler characteristics.
AC_CHECK_HEADER_STDBOOL
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_OFF_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_DEFINE_UNQUOTED([VEX_VERSION],[${VEX_VERSION}],[The VEX SVN Version])
XORG_CHECK_MALLOC_ZERO
XORG_MEMORY_CHECK_FLAGS
GNOME_DEBUG_CHECK

AC_CHECK_TYPES([bfd_vma])
AC_CHECK_SIZEOF([bfd_vma],[],[#include <bfd.h>])
AC_CHECK_ALIGNOF([bfd_vma],[],[#include <bfd.h>])

# Checks for library functions.
AC_FUNC_ERROR_AT_LINE
AC_FUNC_MALLOC
AM_WITH_DMALLOC
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_CHECK_FUNCS([bzero floor memset munmap printf rint scanf sqrt \
                strstr strtoul])

# Check for library function versions

AC_CONFIG_FILES([Makefile
                 libasmir/Makefile
                 libasmir/apps/Makefile
                 libasmir/src/Makefile
                 libtracewrap/Makefile
                 ocaml/Makefile
                 utils/Makefile
                 tests/Makefile])
AC_CONFIG_SUBDIRS([libtracewrap/libtrace
                   ocamlgraph-1.8
                   zarith-1.0])
AC_OUTPUT
