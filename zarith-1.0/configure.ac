dnl#                                               -*- Autoconf -*-
dnl# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([zarith],[1.0],[http://forge.ocamlcore.org/projects/zarith])
AC_CONFIG_SRCDIR([caml_z.c])
AC_CONFIG_HEADERS([config.h])
AC_CANONICAL_TARGET
AC_USE_SYSTEM_EXTENSIONS
AM_DEP_TRACK
AM_MAINTAINER_MODE

# Checks for programs.
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
if test "x${CC}" = "x"; then
  test -z "${CC}"
  AC_PROG_CC
else
  test -n "${CC}" && test -x "${CC}" && export CC
  AC_SUBST([CC])
fi
if test "x${CPP}" = "x"; then
  test -z "${CPP}"
  AC_PROG_CPP
fi
AC_PROG_CXX
AC_PROG_INSTALL
AM_PROG_INSTALL_STRIP
AC_SUBST([INSTALL])dnl
AC_PROG_MAKE_SET
AC_PROG_MKDIR_P
AC_PATH_PROGS([PERL],[perl perl5])dnl
AC_PATH_PROG([UNAME],[uname])dnl

AC_CHECK_PROG([OCAML],[ocaml],[ocaml],[no])
if test "x${OCAML}" = "xno"; then
  AC_MSG_ERROR([Cannot find ocaml.])
fi

AC_MSG_CHECKING([OCaml's word size])
echo "print_int (Sys.word_size);;" > tmp.ml
wordsize=`ocaml tmp.ml`
AC_MSG_RESULT([${wordsize}])
rm -f tmp.ml

case ${host_os} in
    x86_64-*linux-gnu)
        CFLAGS="-DZ_ELF ${CFLAGS}"
        arch='x86_64';;
    i686-*linux-gnu)
        CFLAGS="-DZ_ELF ${CFLAGS}"
        arch='i686';;
    i686-*cygwin)
        if test "x${wordsize}" = "x64"; then
            CFLAGS="-DZ_COFF ${CFLAGS}"
            arch='x86_64_mingw64'
        else
            CFLAGS="-DZ_UNDERSCORE_PREFIX -DZ_COFF $CFLAGS"
            arch='i686'
        fi
	;;
    *darwin*)
        ccdef="-DZ_UNDERSCORE_PREFIX -DZ_MACOS $CFLAGS"
        if test "x${wordsize}" = "x64"; then
            CFLAGS="-arch x86_64 ${CFLAGS}"
            ASFLAGS="-arch x86_64 ${ASFLAGS}"
            arch='x86_64'
        else
            CFLAGS="-arch i386 ${CFLAGS}"
            ASFLAGS="-arch i386 ${ASFLAGS}"
            arch='i686'
        fi
        ;;
    none)
        ;;
    *) 
        AC_MSG_WARN([unknown host ${host_os}]);;
esac

AC_DEFUN([AC_REQUIRE_SED],[
  AC_REQUIRE([AC_PROG_SED])dnl
])dnl
AC_REQUIRE_SED

AC_CHECK_PROG([OCAMLC],[ocamlc],[ocamlc],[no])
if test "x${OCAMLC}" = "xno"; then
  AC_MSG_ERROR([Cannot find ocamlc.])
fi

AC_CHECK_PROG([OCAMLOPT],[ocamlopt],[ocamlopt],[])
OCAMLBEST=byte
if test "x${OCAMLOPT}" = "x"; then
  AC_MSG_WARN([Cannot find ocamlopt; bytecode compilation only.])
else
  AC_MSG_CHECKING([ocamlopt version])
  TMPVERSION="`${OCAMLOPT} -v | sed -n -e 's|.*version *\(.*\)$|\1|p' `"
  if test "${TMPVERSION}" != "${OCAMLVERSION}" ; then
    AC_MSG_RESULT([differs from ocamlc; ocamlopt discarded.])
    unset OCAMLOPT
  else
    AC_SUBST([OCAMLOPT])
    AC_MSG_RESULT([ok])
    OCAMLBEST=opt
  fi
fi

AC_CHECK_PROG([OCAMLCDOTOPT],[ocamlc.opt],[ocamlc.opt],[no])
if test "x${OCAMLCDOTOPT}" != "xno"; then
  AC_MSG_CHECKING([ocamlc.opt version])
  TMPVERSION=`${OCAMLCDOTOPT} -v | sed -n -e 's|.*version *\(.*\)$|\1|p' `
  if test "x${TMPVERSION}" != "x${OCAMLVERSION}"; then
    AC_MSG_RESULT([differs from ocamlc; ocamlc.opt discarded.])
  else
    AC_MSG_RESULT([ok])
    OCAMLC=${OCAMLCDOTOPT}
  fi
fi

if test "x${OCAMLOPT}" != "xno"; then
  AC_CHECK_PROG([OCAMLOPTDOTOPT],[ocamlopt.opt],[ocamlopt.opt],[no])
  if test "x${OCAMLOPTDOTOPT}" != "xno"; then
    AC_MSG_CHECKING([ocamlc.opt version])
    TMPVER=`${OCAMLOPTDOTOPT} -v | sed -n -e 's|.*version *\(.*\)$|\1|p' `
    if test "x${TMPVER}" != "x${OCAMLVERSION}"; then
      AC_MSG_RESULT([differs from ocamlc; ocamlopt.opt discarded.])
    else
      AC_MSG_RESULT([ok])
      OCAMLOPT=${OCAMLOPTDOTOPT}
    fi
  fi
fi

AC_CHECK_PROG([OCAMLDEP],[ocamldep],[ocamldep],[no])
if test "x${OCAMLDEP}" = "xno"; then
  AC_MSG_WARN([Cannot find ocamldep.])
fi

AC_CHECK_PROG([OCAMLDOC],[ocamldoc],[ocamldoc],[true])
if test "x${OCAMLDOC}" = "xtrue"; then
  AC_MSG_WARN([Cannot find ocamldoc])
else
  AC_CHECK_PROG([OCAMLDOCOPT],[ocamldoc.opt],[ocamldoc.opt],[no])
  if test "x${OCAMLDOCOPT}" != "xno"; then
    OCAMLDOC=${OCAMLDOCOPT}
  fi
fi

AC_CHECK_PROG([OCAMLFIND],[ocamlfind],[ocamlfind])
if test "x${OCAMLFIND}" != "xno"; then
  INSTMETH=findlib
  INSTALLDIR=`ocamlfind printconf destdir`
elif "x${INSTALL}" != "x"; then
  INSTMETH=install
  if test "${OCAMLC}" != "no"; then
    INSTALLDIR=`ocamlc -where`
  fi
else
  AC_MSG_ERROR([no installation method found])
fi
export INSTMETH
AC_SUBST([INSTMETH])dnl
export INSTALLDIR
AC_SUBST([INSTALLDIR])dnl

AC_CHECK_PROG([OCAMLMKLIB],[ocamlmklib],[ocamlmklib],[no])
if test "x${OCAMLMKLIB}" = "xno"; then
  AC_MSG_WARN([Cannot find ocamlmklib.])
fi

# Checks for libraries.
AC_CHECK_LIB([c],[printf])dnl
# FIXME: Replace `main' with a function in `-lgmp':
AC_CHECK_LIB([gmp],[main],[CFLAGS="-DHAS_GMP ${CFLAGS}"])dnl
AC_CHECK_LIB([m],[cos])dnl
# FIXME: Replace `main' with a function in `-lmpir':
AC_CHECK_LIB([mpir],[main],[CFLAGS="-DHAS_MPIR ${CFLAGS}"])dnl
AC_CHECK_LIB([z],[gzlib])dnl

# Checks for header files.
if test ! -z "${ocamllibdir}"; then
  test -n "${ocamllibdir}" && test -d "${ocamllibdir}" && export CPPFLAGS="-I${ocamllibdir} ${CPPFLAGS}"
fi
AC_HEADER_STDBOOL dnl# also "_CHECK"s it
AC_CHECK_HEADERS([caml/mlvalues.h float.h gmp.h math.h mpir.h \
                  stddef.h stdio.h])dnl

# Checks for typedefs, structures, and compiler characteristics.
AC_C_BIGENDIAN
AC_C_CONST
AC_C_INLINE
AC_C_PROTOTYPES
AC_TYPE_SIZE_T

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_OBSTACK
AC_CHECK_FUNCS([atexit memset])dnl

# Output.
AC_SUBST([ASFLAGS])dnl
AC_SUBST([OCAMLC])dnl
AC_SUBST([OCAMLDEP])dnl
AC_SUBST([OCAMLDOC])dnl
AC_SUBST([OCAMLFIND])dnl
AC_SUBST([OCAMLMKLIB])dnl

AC_CONFIG_FILES([Makefile_orig])dnl
AC_OUTPUT
