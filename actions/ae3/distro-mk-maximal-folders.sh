#/bin/sh

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "$MMDAPP/source/myx/myx.distro-prepare/sh-lib/MakePrepareDistro.include"

MakePrepareDistro


ListPackageFiles --deep --distro myx --distro ae3 --distro ndm --preset maximal \
	ae3/ae3.web \
	myx/ae3.web.myx-local \
	ndm/com.ndmsystems.ndls \
	ndm/com.ndmsystems.ndss
