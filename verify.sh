#!/bin/sh
if [ -z $1 ] || [ -z $2 ]; then
	echo "Usage: ${0} bitcoin-abc-x.y.z-x86_64-linux-gnu.tar.gz bitcoin-abc-linux-res.yml"
	exit 1
fi
sha256sum -c $2 2> /dev/null | grep $1
