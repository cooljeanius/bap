## Makefile for ounit

TESTFLAGS_COMMENTED_OUT=-only-test "OUnit:1"
default: test

# OASIS_START
# DO NOT EDIT (digest: bc1e05bfc8b39b664f29dae8dbd3ebbb)

SETUP = ocaml setup.ml

build: setup.data
	$(SETUP) -build $(BUILDFLAGS)

doc: setup.data build
	$(SETUP) -doc $(DOCFLAGS)

test: setup.data build
	$(SETUP) -test $(TESTFLAGS)

all: 
	$(SETUP) -all $(ALLFLAGS)

install: setup.data
	$(SETUP) -install $(INSTALLFLAGS)

uninstall: setup.data
	$(SETUP) -uninstall $(UNINSTALLFLAGS)

reinstall: setup.data
	$(SETUP) -reinstall $(REINSTALLFLAGS)

clean: 
	-$(SETUP) -clean $(CLEANFLAGS)

distclean: 
	-$(SETUP) -distclean $(DISTCLEANFLAGS)
	-rm -f cscopelist

maintainer-clean: distclean
	@echo "This target is intended for maintainers to use."
	@echo "It can delete files that may require special tools to rebuild, and other junk."
	@-find . -name .DS_Store -delete 2>/dev/null
	@-rm -f cscopelist

setup.data:
	$(SETUP) -configure $(CONFIGUREFLAGS)

.PHONY: build doc test all install uninstall reinstall clean distclean configure maintainer-clean

# OASIS_STOP

doc-test: doc
	 ocamldoc -g ../ocaml-tmp/odoc-extract-code/odoc_extract_code.cmo \
		 -load _build/src/oUnit.odoc -intro doc/manual.txt > _build/src/tmp.ml;
	 ocamlc -c -I _build/src/ _build/src/tmp.ml

tags:
	-

cscopelist:
	touch $@
