#!/bin/sh

set -e

echo "It would be a better idea to just run \`autoreconf' with your favorite flags, but whatever..."

set -ex

test ! -z "`which aclocal`" && aclocal --force -I m4
test ! -z "`which autoconf`" && autoconf --force
test ! -z "`which autoheader`" && autoheader --force
test ! -z "`which automake`" && automake --add-missing --copy --force-missing
(cd libtracewrap/libtrace && sh ./autogen.sh)

test -d autom4te.cache && rm -rf autom4te.cache
test -e config.h.in~ && rm -f config.h.in~
exit 0
