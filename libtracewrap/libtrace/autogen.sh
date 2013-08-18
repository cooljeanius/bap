#!/bin/sh

set -e

echo "It would probably be a better idea to just run \`autoreconf' with your flags of choice, but whatever..."

set -ex

test ! -z "`which aclocal`" && aclocal --force -I m4
test ! -z "`which autoconf`" && autoconf --force
test ! -z "`which autoheader`" && autoheader --force
test ! -z "`which automake`" && automake --add-missing --copy --force-missing

cd protobuf && sh ./autogen.sh

if [ ! -z "$OLDPWD" ]; then
	cd $OLDPWD
fi

test -e autom4te.cache && rm -rf autom4te.cache
test -e config.h.in~ && rm -rf config.h.in~
exit 0
