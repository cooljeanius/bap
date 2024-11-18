#!/bin/sh

# this one should be for the top level directory for bap

set -e

echo "It may be a better idea to just run 'autoreconf' with your favorite flags in `pwd` instead of $0, but whatever..."

set -ex

test -n "`which aclocal`" && aclocal --force --warnings=all,no-obsolete -I m4 --install
test -n "`which autoconf`" && autoconf --force --warnings=all,no-obsolete,no-cross
test -n "`which autoheader`" && autoheader --force --warnings=all
test -n "`which automake`" && automake --add-missing --copy --force-missing --warnings=all
(cd libtracewrap/libtrace && sh ./autogen.sh)
(cd ocamlgraph-1.8 && sh ./autogen.sh)
(cd zarith-1.0 && autoreconf -fvi -Wall)

test -d autom4te.cache && (rm -rf autom4te.cache || rmdir autom4te.cache)
test -e config.h.in~ && rm -f config.h.in~
test -e configure~ && rm -f configure~
test -e libasmir/config.h.in~ && rm -f libasmir/config.h.in~
test -d zarith-1.0/autom4te.cache && (rm -rf zarith-1.0/autom4te.cache || rmdir zarith-1.0/autom4te.cache)
test -e zarith-1.0/config.h.in~ && rm -f zarith-1.0/config.h.in~
test -e zarith-1.0/configure~ && rm -f zarith-1.0/configure~
exit 0
