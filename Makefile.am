ACLOCAL_AMFLAGS = -I m4

# Work around buggy Debian ocaml patch
# See http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=678577
export OCAML_COMPAT='c'

if HAVE_PIN
PINTRACES=pintraces
endif

BAPDIRS=libasmir ocaml utils tests $(PINTRACES)
SUBDIRS=batteries zarith-1.0 ounit pcre-ocaml ocamlgraph-1.8 objsize-0.16 libtracewrap VEX $(BAPDIRS)

test: all
	$(MAKE) -C tests test

install-intentional-failure:
	@echo "BAP does not support the install target"
	@false

.PHONY: cscope-local install-intentional-failure

cscope-local:
	cscope -b `find . -name "*.[ch]" -or -name "*.hh" -or -name "*.cc" -or -name "*.cpp"`

.PHONY: bap-clean
bap-clean:
	for d in $(BAPDIRS); do $(MAKE) -C $$d clean; done

if HAVE_ETAGS
all-local: tags
endif
