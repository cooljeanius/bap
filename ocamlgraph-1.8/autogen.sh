#!/bin/sh

# this one should be for ocamlgraph-1.8

set -e

echo "It would be a better idea to just run \`autoreconf' with your favorite flags in `pwd` instead of $0, but whatever..."
# ...but put that off, because of the differing warning flags between steps.

set -ex

test ! -z "`which aclocal`" && aclocal --force --warnings=all -I m4 --install
test ! -z "`which autoconf`" && autoconf --force --warnings=all,no-cross,no-obsolete
test ! -z "`which autoheader`" && autoheader --force --warnings=all

test -d autom4te.cache && (rm -rf autom4te.cache || rmdir autom4te.cache)
test -e config.h.in~ && rm -f config.h.in~
test -e configure~ && rm -f configure~
exit 0
