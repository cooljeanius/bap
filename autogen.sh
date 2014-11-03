#!/bin/sh

# this one should be for the top level directory for bap

set -e

echo "It would be a better idea to just run \`autoreconf' with your favorite flags instead of $0, but whatever..."

set -ex

test ! -z "`which aclocal`" && aclocal --force --warnings=all,no-obsolete -I m4 --install
test ! -z "`which autoconf`" && autoconf --force --warnings=all,no-obsolete,no-cross
test ! -z "`which autoheader`" && autoheader --force --warnings=all
test ! -z "`which automake`" && automake --add-missing --copy --force-missing --warnings=all
(cd libtracewrap/libtrace && sh ./autogen.sh)
(cd ocamlgraph-1.8 && sh ./autogen.sh)
(cd zarith-1.0 && autoreconf -fvi -Wall)

test -d autom4te.cache && (rm -rf autom4te.cache || rmdir autom4te.cache)
test -e config.h.in~ && rm -f config.h.in~
test -d zarith-1.0/autom4te.cache && rm -rf zarith-1.0/autom4te.cache
test -e zarith-1.0/config.h.in~ && rm -f zarith-1.0/config.h.in~
exit 0
