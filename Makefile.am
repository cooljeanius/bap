## top-level automake Makefile for bap

ACLOCAL_AMFLAGS = -I m4 --install

noinst_SCRIPTS = autogen.sh

# Work around buggy Debian ocaml patch
# See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678577
export OCAML_COMPAT='c'

if HAVE_PIN
PINTRACES=pintraces
endif

BAPDIRS=libasmir ocaml utils tests $(PINTRACES)
SUBDIRS=batteries zarith-1.0 ounit pcre-ocaml ocamlgraph-1.8 objsize-0.16 libtracewrap VEX $(BAPDIRS)

DISTCLEANFILES = *.log config.status

test: all
	$(MAKE) -C tests test

check-local: test
.PHONY: test check-local

install-intentional-failure:
	@echo "BAP does not support the install target" >&2
	@false

.PHONY: cscope-local install-intentional-failure

cscope-local:
	cscope -b `find . -name "*.[ch]" -or -name "*.hh" -or -name "*.cc" -or -name "*.cpp"`

.PHONY: bap-clean maintainer-clean-local distclean-local
bap-clean:
	for d in $(BAPDIRS); do $(MAKE) -C $${d} clean; done

maintainer-clean-local: bap-clean distclean-local
	@echo "BAP is still working on cleaning for maintainers"

distclean-local:
	rm -rf autom4te.cache || rmdir autom4te.cache

if HAVE_ETAGS
all-local: tags
endif
