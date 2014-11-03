#!/bin/sh

# this one should be in libtracewrap/libtrace

set -e

echo "It would probably be a better idea to just run \`autoreconf' with your flags of choice instead of $0, but whatever..."

set -ex

test ! -z "`which aclocal`" && aclocal --force --warnings=all,no-obsolete -I m4 --install
test ! -z "`which autoconf`" && autoconf --force --warnings=all,no-cross
test ! -z "`which autoheader`" && autoheader --force --warnings=all
test ! -z "`which automake`" && automake --add-missing --copy --force-missing --warnings=all

cd protobuf && sh ./autogen.sh

if [ ! -z "${OLDPWD}" ]; then
	if [ -d "${OLDPWD}" ]; then
		cd ${OLDPWD}
	fi
fi

if [ -d piqi/piqi ]; then
	(cd piqi/piqi && autoreconf -fvi -Wall)
fi

test -d autom4te.cache && (rm -rf autom4te.cache || rmdir autom4te.cache)
test -e config.h.in~ && rm -f config.h.in~
test -d piqi/piqi/autom4te.cache && rm -rf piqi/piqi/autom4te.cache
test -e piqi/piqi/config.h.in~ && rm -f piqi/piqi/config.h.in~
exit 0
