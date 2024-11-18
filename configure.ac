# Owned and copyright BitBlaze, 2007. All rights reserved.
# Do not copy, disclose, or distribute without explicit written
# permission.
# (Oops, too late for that...)

dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([Bap],[0.7],[bap-dev@lists.andrew.cmu.edu])
AC_CONFIG_SRCDIR([libasmir/src/asm_program.c])
AC_CONFIG_HEADER([libasmir/config.h])
AC_CONFIG_MACRO_DIR([m4])dnl

AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS

AB_INIT
AM_INIT_AUTOMAKE([gnits subdir-objects -Wall -Wno-obsolete -Wno-cross])
GNOME_MAINTAINER_MODE_DEFINES dnl# calls AM\_MAINTAINER\_MODE

m4_include([./m4/ac_ocaml.m4])
m4_include([./m4/ac_prog_latex.m4])

# Checks for programs.
AC_MSG_CHECKING([programs])
AC_MSG_RESULT([ ])
AM_PROG_AR
if test "x${AR}" = "x"; then
  test -z "${AR}" || unset AR
  ## might want to switch around these checks...
  if test "x${ac_cv_prog_AR}" = "x"; then
    test -z "${ac_cv_prog_AR}" || unset ac_cv_prog_AR
    m4_ifdef([AC_PROG_AR],[
      AC_PROG_AR
    ],[
      test -x "`which ar`" && echo "which ar? `which ar`"
    ])
  fi
else
  test -n "${AR}" && test -x "${AR}" && export AR
fi
AM_PROG_AS
AC_PROG_CXX
if test "x${AWK}" = "x"; then
  test -z "${AWK}" || unset AWK
  AC_PROG_AWK
else
  test -n "${AWK}" && test -x "${AWK}" && export AWK
  AC_SUBST([AWK])
fi
if test "x${CC}" = "x"; then
  test -z "${CC}" || unset CC
  AC_PROG_CC
else
  test -n "${CC}" && test -x "${CC}" && export CC
  AC_SUBST([CC])
fi
if test "x${CPP}" = "x"; then
  test -z "${CPP}" || unset CPP
  AC_PROG_CPP
else
  test -n "${CPP}" && test -x "${CPP}" && echo "CPP set to: '${CPP}'"
  XORG_PROG_RAWCPP([])
fi
if test "x${INSTALL}" = "x"; then
  test -z "${INSTALL}" || unset INSTALL
  AC_PROG_INSTALL
  AM_PROG_INSTALL_STRIP
else
  test -n "${INSTALL}" && test -x "${INSTALL}" && export INSTALL
  AC_SUBST([INSTALL])
fi
AC_PROG_LN_S
if test "x${MAKE}" = "x"; then
  test -z "${MAKE}" || unset MAKE
  AC_PATH_PROGS([MAKE],[make gmake gnumake remake])
  AC_PROG_MAKE_SET
else
  test -n "${MAKE}" && test -x "${MAKE}" && export MAKE
  AC_SUBST([MAKE])
fi
AX_CHECK_GNU_MAKE
AM_PROG_LEX
AC_PROG_YACC
AC_PROG_OCAML([3.12.0])
AC_PROG_CAMLP4
AC_PROG_OCAMLFIND
AC_PROG_CAMLIDL
LT_INIT([win32-dll dlopen])
dnl# temporarily set this while I update everything libtool-related:
LT_PREREQ([2.4.6])dnl
  ## languages:
LT_LANG([C])dnl
LT_LANG([C++])dnl
LT_LANG([Java])dnl
LT_LANG([Windows Resource])
if test "x${RANLIB}" = "x"; then
  test -z "${RANLIB}" || unset RANLIB
  AC_PROG_RANLIB
else
  test -n "${RANLIB}" && test -x "${RANLIB}" && export RANLIB
  AC_SUBST([RANLIB])
fi
PKG_PROG_PKG_CONFIG

AM_CONDITIONAL([GCC],[test "x${GCC}" = "xyes"]) # let Makefiles know we are gcc

# Check for Z3:
AC_ARG_WITH([z3],
            [AS_HELP_STRING([--with-z3],
                            [location of Z3 library])],
            [with_z3=${withval}],
            [with_z3=no])dnl

# Save pre-z3 ldflags:
OLDLDFLAGS=${LDFLAGS}

AS_IF([test "x${with_z3}" != "xno"],
      [LDFLAGS="${OLDLDFLAGS} -L${with_z3}/lib"
       AC_CHECK_LIB([z3],[Z3_mk_bvadd],[
         z3_dir=${with_z3}
         with_z3=yes
         AC_DEFINE([HAVE_Z3_BINDINGS],[1],[Define to 1 to use Z3 bindings])
       ],[
         AC_MSG_FAILURE([z3 library requested but not found])
       ],[-lgmp -lgomp])
     ])dnl

# Restore:
LDFLAGS=${OLDLDFLAGS}

rm -f solvers/makefile.inc
if `test "x${with_z3}" = "xyes"`; then
   cat >>solvers/makefile.inc <<"EOF"
SOLVER_PPFLAGS=-D WITH_Z3_BINDINGS
SOLVER_CLIBS = z3stubs z3
EOF
echo "SOLVER_SOURCES = ${z3_dir}/ocaml/z3.ml" >>solvers/makefile.inc
echo "SOLVER_LIBDIRS = ${z3_dir}/lib" >>solvers/makefile.inc
echo "SOLVER_LDFLAGS = -fopenmp -Wl,-rpath=${z3_dir}/lib" >> solvers/makefile.inc
else
   touch solvers/makefile.inc
fi

# Add -DAMD64 when needed:
if test "$(uname -m)" == "x86_64";
   then export CFLAGS="${CFLAGS} -DAMD64";
fi

# Check for PIN:
PIN_HOME=${PIN_HOME:=$(pwd)/pin}
AC_CHECK_FILE([${PIN_HOME}],
              [HAVE_PIN=true],
              [HAVE_PIN=false
               AC_MSG_WARN([Pin not found; disabling BAP pintraces.])
])dnl

AM_CONDITIONAL([HAVE_PIN],[test "x${HAVE_PIN}" = "xtrue"])dnl

# Conditionally build llvm:
AC_MSG_CHECKING([llvm ocaml libraries])
AC_ARG_WITH([llvm],
            [AS_HELP_STRING([[--with-llvm=[=ARG]]],
                            [use OCaml llvm package named ARG])],
            [LIBLLVM="${withval}"],
            [LIBLLVM="check"])dnl

AS_IF([test "x${LIBLLVM}" = "xno"],
      [LLVM_PACKAGE=""],
      [AS_IF([test "x${LIBLLVM}" = "xyes" -o "x${LIBLLVM}" = "xcheck"],
             [AS_IF([ocamlfind query llvm >/dev/null 2>&1],
             [LLVM_PACKAGE="llvm"],
             [AS_IF([ocamlfind query llvm-3_1 >/dev/null 2>&1],
                    [LLVM_PACKAGE="llvm-3_1"],
                    [LLVM_PACKAGE=""])])],
             [AS_IF([ocamlfind query ${LIBLLVM} >/dev/null 2>&1],
                    [LLVM_PACKAGE="${LIBLLVM}"],
                    [])])])dnl

AS_IF([test \( "x${LIBLLVM}" != "xno" -a "x${LIBLLVM}" != "xcheck" \) -a "x${LLVM_PACKAGE}" = "x"],
      [AC_MSG_FAILURE([--with-llvm specified but llvm was not found])],
      [])dnl

AC_SUBST([LLVM_PACKAGE])dnl

AS_IF([test "x${LLVM_PACKAGE}" != "x"],
      [HAVE_LLVM_AC=yes],[HAVE_LLVM_AC=no])dnl
      ## ...which implies:
AS_IF([test "x${HAVE_LLVM_AC}" = "xyes"],
      [AC_MSG_RESULT([${HAVE_LLVM_AC} (${LLVM_PACKAGE})])],
      [AC_MSG_RESULT([${HAVE_LLVM_AC}])])dnl
AC_SUBST([HAVE_LLVM_AC])dnl

AS_IF([test "x${HAVE_LLVM_AC}" = "xtrue"],
      [LLVM_PPFLAGS="-D WITH_LLVM"],
      [])dnl
AC_SUBST([LLVM_PPFLAGS])dnl

# Check for etags:
AS_IF([which etags >/dev/null 2>&1],
      [HAVE_ETAGS=true],
      [HAVE_ETAGS=false
       AC_MSG_WARN([ETAGS not found. BAP will not build tags.])
])dnl

AM_CONDITIONAL([HAVE_ETAGS],[test "x${HAVE_ETAGS}" = "xtrue"])dnl

# Checks for ocaml libraries:
AC_MSG_CHECKING([for camomile])
ocamlfind query camomile >/dev/null 2>&1
if test $? != 0; then
   AC_MSG_RESULT([no])
   AC_MSG_WARN([camomile ocaml package not found: This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])
else
   AC_MSG_RESULT([yes])
fi

# Batteries (passed to libtrace).
AC_ARG_WITH([batteries],
            [AS_HELP_STRING([--with-batteries],
            [specify path to batteries (directory must actually exist)])],
            [with_batteries="$( cd ${withval} && pwd )"],
            [AS_IF([test "x${srcdir}" != "x"],
                   [AS_IF([test -d "${srcdir}/batteries"],
                          [with_batteries="${srcdir}/batteries"],
                          [AS_IF([test -d ./batteries],
                                 [with_batteries=./batteries])])])])dnl

AS_IF([test "x${with_batteries}" != "x"],
      [test -n "${with_batteries}"
       AC_MSG_CHECKING([for batteries directory])
       AS_IF([test -d "${with_batteries}"],
             [AC_MSG_RESULT([found])
              AC_SUBST([TOP_BAT_DIR],[${with_batteries}])],
             [AC_MSG_RESULT([no])])],
      [AC_MSG_WARN([libtrace will want to know where batteries are.])])

VEX_DIR=`pwd`/'VEX'
VEX_VERSION=2201

# Checks for libraries.
AC_MSG_CHECKING([libraries])
AC_MSG_RESULT([ ])
if test "x${acl_cv_wl}" = "x"; then
  test -z "${acl_cv_wl}" && export acl_cv_wl='-Wl,'
fi
AC_SUBST([acl_cv_wl])dnl
AC_CACHE_CHECK([if the linker accepts ${acl_cv_wl}-fatal_warnings],
               [bap_cv_ld_werror],
               [pre_saved_LDFLAGS="${LDFLAGS}"
                LDFLAGS="${LDFLAGS} ${acl_cv_wl}-fatal_warnings"
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[]],[[]])],
	                       [bap_cv_ld_werror=yes],
	                       [bap_cv_ld_werror=no])
                LDFLAGS="${pre_saved_LDFLAGS}"])
AC_CACHE_CHECK([if the linker accepts ${acl_cv_wl}-arch_errors_fatal],
               [bap_cv_ld_arch_werror],
               [pre_saved_LDFLAGS="${LDFLAGS}"
                LDFLAGS="${LDFLAGS} ${acl_cv_wl}-arch_errors_fatal"
                AC_LINK_IFELSE([AC_LANG_PROGRAM([[]],[[]])],
	                       [bap_cv_ld_arch_werror=yes],
	                       [bap_cv_ld_arch_werror=no])
                LDFLAGS="${pre_saved_LDFLAGS}"])
# Use the flag to make sure the libraries we check actually link correctly:
SAVE_LDFLAGS="${LDFLAGS}"
AS_IF([test "x${bap_cv_ld_werror}" = "xyes"],
      [AS_CASE(["${LDFLAGS}"],
               [*${acl_cv_wl}-warn*],
               [export LDFLAGS="${acl_cv_wl}-fatal_warnings"],
               [LDFLAGS="${LDFLAGS} ${acl_cv_wl}-fatal_warnings"])])dnl
  ## If that failed, try this:
AS_IF([test "x${bap_cv_ld_arch_werror}" = "xyes"],
      [AS_CASE(["${LDFLAGS}"],
               [*${acl_cv_wl}-warn*],
               [export LDFLAGS="${acl_cv_wl}-arch_errors_fatal"],
               [LDFLAGS="${LDFLAGS} ${acl_cv_wl}-arch_errors_fatal"])])dnl
  ## OK, now actually check the libraries:
AC_CHECK_LIB([bfd],[bfd_init],[],[
  AC_CHECK_LIB([bfd],[main],[],[
    AC_MSG_WARN([BFD library not found: This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])
    echo "Make sure that the first libbfd that your linker finds is built with the correct architecture."
  ])dnl
])dnl
AC_CHECK_LIB([iberty],[xmalloc],[],[
  AC_CHECK_LIB([iberty],[main],[],[
    AC_MSG_WARN([libiberty not found: This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])
    echo "Make sure that the first libiberty that your linker finds is built with the correct architecture."
  ])dnl
])dnl
AC_CHECK_LIB([pcre],[pcre_config],[],[
  AC_CHECK_LIB([pcre],[main],[],[
    AC_CHECK_LIB([pcreposix],[main],[
      AC_MSG_WARN([trying to use libpcreposix in the absence of just plain libpcre; this is untested])
    ],[
      AC_MSG_ERROR([PCRE library not found])
    ])dnl
  ])dnl
])dnl
# zlib is apparently needed by bfd:
AC_CHECK_LIB([z],[inflate],[],[
  AC_CHECK_LIB([z],[main],[],[
    AC_MSG_ERROR([zlib library not found])
  ])dnl
])dnl

# More checks for libraries
AC_CHECK_LIB([asmir],[asmir_open_file],[],[
  AC_CHECK_LIB([asmir],[main])dnl
])dnl
AC_CHECK_LIB([c],[printf])dnl
AC_CHECK_LIB([dl],[dlsym])dnl
AC_CHECK_LIB([m],[sqrt])dnl
LT_LIB_M
AC_CHECK_LIB([opcodes],[print_insn],[],[
  AC_CHECK_LIB([opcodes],[main])dnl
])dnl
AC_SEARCH_LIBS([disassemble],[bfd opcodes])dnl
AC_CHECK_LIB([protobuf],[protobuf_c_version],[],[
  AC_CHECK_LIB([protobuf],[main])dnl
])dnl
AC_CHECK_LIB([pthread],[pthread_create])dnl
AC_CHECK_LIB([vex],[LibVEX_default_VexControl],[],[
  AC_CHECK_LIB([vex],[main])dnl
])dnl
AC_CHECK_LIB([stdc++],[__cxa_atexit],[],[
  AC_CHECK_LIB([stdc++],[main])dnl
])dnl

LDFLAGS="${SAVE_LDFLAGS}"

AC_SUBST([VEX_DIR])dnl

AC_SUBST([INCDIRS])dnl

if test "x${acl_cv_wp}" = "x"; then
  test -z "${acl_cv_wp}" && export acl_cv_wp='-Wp,'
fi
AC_SUBST([acl_cv_wp])dnl

rm -f libasmir/makefile.inc
echo "VEX_DIR=${VEX_DIR}" >> libasmir/makefile.inc
echo "LIBASMIR_CXXFLAGS=${acl_cv_wp}-I${VEX_DIR}/pub ${acl_cv_wp}-I`pwd`/src/include ${CXXFLAGS}" >> libasmir/makefile.inc
echo "LIBASMIR_LDFLAGS=-L${VEX_DIR} -L`pwd`/src ${LDFLAGS}" >> libasmir/makefile.inc
echo "LIBASMIR_LIBS=-lasmir -lvex -lbfd -ldl -liberty -lz" >> libasmir/makefile.inc
echo "CLIBS=asmir vex opcodes bfd z iberty stdc++" >> libasmir/makefile.inc
ASMIR_DIR="`pwd`/libasmir"
AC_SUBST([ASMIR_DIR])dnl

BAP_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
AC_SUBST([BAP_DIR])dnl

# Checks for header files.
# Some of these following header checks are duplicates, but we need to do
# it again so that we can error out if any are missing:
AC_MSG_NOTICE([re-checking standard headers])
unset ac_cv_header_inttypes_h
unset ac_cv_header_stdint_h
unset ac_cv_header_stdlib_h
unset ac_cv_header_string_h
unset ac_cv_header_unistd_h
AC_CHECK_HEADERS([fcntl.h inttypes.h stdint.h stdio.h stdlib.h string.h unistd.h],
   [],[AC_MSG_ERROR([Standard headers missing])])
# Just check these without erroring out:
AC_MSG_CHECKING([other headers])
AC_MSG_RESULT([ ])
AC_CHECK_HEADERS([dis-asm.h float.h limits.h locale.h malloc.h \
                  malloc/malloc.h mem/memory.h stddef.h sys/file.h \
                  sys/inttypes.h sys/ioctl.h sys/socket.h sys/time.h \
                  sys/timeb.h wchar.h])
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
# These headers are from specific packages so they get specific error
# messages:
AC_CHECK_HEADER([bfd.h],[],
   [AC_MSG_WARN([You need BFD headers (e.g., libbfd-dev): This ought to be an error but it has been changed to a warning to facilitate work on this configure script.])])
AC_CHECK_HEADER([pcre.h],[],
   [AC_CHECK_HEADER([pcre/pcre.h],[],
      [AC_CHECK_HEADER([pcrelib/pcre.h],[],
         [AC_MSG_ERROR([You need libpcre headers (e.g., libpcre3-dev)])])])])
AC_CHECK_HEADER([caml/camlidlruntime.h],[],
   [AC_MSG_WARN([the optional z3 package will want to include <caml/camlidlruntime.h>, but this header seems to be missing.])])dnl

# Checks for typedefs, structures, and compiler characteristics.
AC_MSG_CHECKING([C compiler characteristics])
AC_MSG_RESULT([ ])
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES
AC_C_VOLATILE
AC_MSG_CHECKING([types and stuff])
AC_MSG_RESULT([ ])
AC_TYPE_INT8_T
AC_TYPE_INT16_T
AC_TYPE_INT32_T
AC_TYPE_INT64_T
AC_TYPE_MODE_T
AC_TYPE_OFF_T
AC_TYPE_PID_T
AC_TYPE_SIZE_T
AC_TYPE_SSIZE_T
AC_TYPE_UINT8_T
AC_TYPE_UINT16_T
AC_TYPE_UINT32_T
AC_TYPE_UINT64_T
AC_CHECK_TYPES([ptrdiff_t])dnl
AC_STRUCT_TIMEZONE dnl# also does the "_TM" one.
AC_DEFINE_UNQUOTED([VEX_VERSION],[${VEX_VERSION}],[The VEX SVN Version])dnl
XORG_CHECK_MALLOC_ZERO
XORG_MEMORY_CHECK_FLAGS
GNOME_DEBUG_CHECK

AC_CHECK_TYPES([bfd_vma])dnl
AC_CHECK_SIZEOF([bfd_vma],[],[#include <bfd.h>])dnl
AC_CHECK_ALIGNOF([bfd_vma],[],[#include <bfd.h>])dnl

# Checks for library functions.
AC_MSG_CHECKING([functions])
AC_MSG_RESULT([ ])
AC_FUNC_ERROR_AT_LINE
AC_FUNC_FORK
AC_FUNC_MALLOC
AM_WITH_DMALLOC
AC_FUNC_MEMCMP
AC_FUNC_MMAP
AC_FUNC_REALLOC
AC_FUNC_STAT
AC_FUNC_STRTOD
AC_CHECK_FUNCS([alarm atexit bzero disassembler dup2 floor gettimeofday \
                memset munmap printf realpath rint scanf setenv setlocale \
                sqrt socket strchr strdup strerror strrchr strstr strtol \
                strtoul strtoull sysinfo system uname])dnl

if test "x${ac_cv_func_getpagesize}" = "x"; then
  test -z "${ac_cv_func_getpagesize}" || unset ac_cv_func_getpagesize
  AC_CHECK_FUNCS([getpagesize])
fi

AC_CHECK_DECLS([disassembler],[],[],[
#ifdef HAVE_DIS_ASM_H
# include <dis-asm.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for disassembler expects <dis-asm.h> to be included."
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_DIS_ASM_H */
])dnl

if test "x${ac_cv_func_disassembler}" = "xyes" || test "x${ac_cv_have_decl_disassembler}" = "xyes" || test "x${ac_cv_search_disassembler}" != "xno"; then
  AC_CACHE_CHECK([how many arguments disassembler function takes],
                 [ac_cv_func_disassembler_num_args],
    [AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
#ifdef HAVE_DIS_ASM_H
# include <dis-asm.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for disassembler expects <dis-asm.h> to be included."
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_DIS_ASM_H */
]],[[
bfd *abfd = NULL;
disassembler(abfd);
]])],[ac_cv_func_disassembler_num_args=1],
     [AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
#ifdef HAVE_DIS_ASM_H
# include <dis-asm.h>
#else
# if defined(__GNUC__) && !defined(__STRICT_ANSI__)
#  warning "conftest for disassembler expects <dis-asm.h> to be included."
# endif /* __GNUC__ && !__STRICT_ANSI__ */
#endif /* HAVE_DIS_ASM_H */
]],[[
bfd *abfd = NULL;
enum bfd_architecture arc = bfd_arch_unknown;
bfd_boolean big = TRUE;
unsigned long mach = 0UL;
disassembler(arc, big, mach, abfd);
]])],[ac_cv_func_disassembler_num_args=4],
     [ac_cv_func_disassembler_num_args=unknown])])])
  AH_TEMPLATE([DISASSEMBLER_NUM_ARGS],
              [number of arguments to the disassembler function])
  if test "x${ac_cv_func_disassembler_num_args}" = "x1"; then
    AC_DEFINE([DISASSEMBLER_NUM_ARGS],[1])
  elif test "x${ac_cv_func_disassembler_num_args}" = "x4"; then
    AC_DEFINE([DISASSEMBLER_NUM_ARGS],[4])
  elif test "x${ac_cv_func_disassembler_num_args}" = "xunknown"; then
    AC_MSG_WARN([disassembler should take either 1 arg or 4 args])
  else
    AC_MSG_WARN([disassembler should take some amount of args])
  fi
else
  AC_MSG_WARN([will want disassembler function somehow])
fi

# Check for library function versions
# (N/A)

# Output.
AC_CONFIG_FILES([Makefile
                 libasmir/Makefile
                 libasmir/apps/Makefile
                 libasmir/src/Makefile
                 libtracewrap/Makefile
                 ocaml/Makefile
                 utils/Makefile
                 tests/Makefile])dnl
AC_CONFIG_SUBDIRS([libtracewrap/libtrace
                   ocamlgraph-1.8
                   zarith-1.0])dnl
AC_OUTPUT
