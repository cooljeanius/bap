#!/bin/bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if test "$(uname -m)" == "x86_64"; then
    url="http://research.microsoft.com/projects/z3/z3-x64-3.2.tar.gz"
else
    url="http://research.microsoft.com/projects/z3/z3-3.2.tar.gz"
fi

if test ! -z "$(which wget)"; then
	wget ${url} -O - | tar -xvz -C ${DIR}
elif test ! -z "$(which curl)"; then
	echo "TODO: convert wget command in this script to equivalent curl command"
	exit 1
else
	echo "No known download program found, try downloading ${url} manually"
	exit 1
fi

set -ex

cd ${DIR}/z3/ocaml && ./build-lib.sh $(ocamlfind query unix)
