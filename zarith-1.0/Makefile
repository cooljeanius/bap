all:
	$(MAKE) -j1 -f Makefile.orig $@

tags:
	-

%:
	$(MAKE) -j1 -f Makefile.orig $@

clean:
	rm -f *.o *~

distclean: clean

Makefile.orig: config.status
	./config.status

config.status: configure
	./configure

configure: configure.ac

.PHONY: clean distclean
