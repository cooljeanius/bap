#!/bin/sh

# this one should be in libtracewrap/libtrace

set -e

echo "It would probably be a better idea to just run 'autoreconf' with your flags of choice in `pwd` instead of $0, but whatever..."

set -ex

test -n "`which aclocal`" && aclocal --force --warnings=all,no-obsolete -I m4 --install
test -n "`which autoconf`" && autoconf --force --warnings=all,no-cross
test -n "`which autoheader`" && autoheader --force --warnings=all
test -n "`which automake`" && automake --add-missing --copy --force-missing --warnings=all

cd protobuf && sh ./autogen.sh

if [ -n "${OLDPWD}" ]; then
	if [ -d "${OLDPWD}" ]; then
		cd ${OLDPWD}
	fi
fi

if [ -d piqi/piqi ]; then
	(cd piqi/piqi && autoreconf -fvi -Wall -Wno-obsolete)
fi

test -d autom4te.cache && (rm -rf autom4te.cache || rmdir autom4te.cache)
test -e config.h.in~ && rm -f config.h.in~
test -e configure~ && rm -f configure~
test -d piqi/piqi/autom4te.cache && rm -rf piqi/piqi/autom4te.cache
test -e piqi/piqi/config.h.in~ && rm -f piqi/piqi/config.h.in~
test -e piqi/piqi/configure~ && rm -f piqi/piqi/configure~
exit 0
