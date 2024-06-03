#!/usr/bin/env sh

# $Id: getpin.sh 6733 2012-09-26 14:22:44Z edmcman $
# Download and extract Pin
# The link in this script is dead; use:
# http://software.intel.com/en-us/articles/pintool-downloads
# instead.

set -ex

# check if pin dir exists first

if test -x "$(which wget)"; then
	wget 'http://software.intel.com/sites/landingpage/pintool/downloads/pin-2.12-53271-gcc.4.4.7-ia32_intel64-linux.tar.gz' -U "Mozilla/5.0 (compatible; MSIE 10.6; Windows NT 6.1; Trident/5.0; InfoPath.2; SLCC1; .NET CLR 3.0.4506.2152; .NET CLR 3.5.30729; .NET CLR 2.0.50727) 3gpp-gba UNTRUSTED/1.0" -O - | tar -xvz -C ..
elif test -x "$(which curl)"; then
	echo "TODO: convert wget command in this script to equivalent curl command" >&2
	exit 1
else
	echo "No known download program found, try downloading pin from http://software.intel.com/en-us/articles/pintool-downloads manually" >&2
	exit 1
fi
rm -rf ../pin
mv ../pin-* ../pin
test -e Makefile & test -d ../pin && make
