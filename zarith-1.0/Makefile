## Handwritten Makefile for zarith-1.0
## basically just calls out to the configured one, which in turn includes
## a different handwritten Makefile called project.mak

all: Makefile_orig
	$(MAKE) -j1 -f Makefile_orig $@

tags:
	-

%:
	$(MAKE) -j1 -f Makefile_orig $@

clean:
	rm -f *.o *.a *.so *.cmi *.cmo *.cmx *.cmxa *.cmxs *.cma *~
	rm -f *.dll \#* test tmp.c cscopelist
	rm -f test.b rtest bitest html

distclean: clean
	rm -f config.status config.log config.h Makefile_orig .DS_Store *~
	-rm -rf autom4te.cache || rmdir autom4te.cache

maintainer-clean: distclean
	@echo "This target is intended for maintainers to use."
	@echo "It can delete files that may require special tools to rebuild, and other junk."
	@-find . -name .DS_Store -delete 2>/dev/null
	rm -f autoscan.log configure.scan

Makefile_orig: config.status
	./config.status

config.status: configure
	./configure

configure: configure.ac

.PHONY: clean distclean maintainer-clean
