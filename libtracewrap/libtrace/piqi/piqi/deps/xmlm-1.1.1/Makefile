OCAMLMAKEFILE := ../../make/OCamlMakefile


RESULT = xmlm


SOURCES = xmlm.ml xmlm.mli


PRE_TARGETS =
LIBS =
INCDIRS =
LIBDIRS =
ANNOTATE = yes
INCDIRS = +camlp4
USE_CAMLP4 = yes
THREADS = yes


OCAMLFLAGS += -verbose
OCAMLLDFLAGS += -verbose


all: bcl ncl


install: libinstall


uninstall: libuninstall


clean::
	rm -fv *.o *.a xmlm.cm* ._*/*.d*

include $(OCAMLMAKEFILE)

