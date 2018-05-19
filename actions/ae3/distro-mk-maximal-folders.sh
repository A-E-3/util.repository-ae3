#/bin/sh

if [ -z "$APP" ] ; then
	set -e
	APP="$( cd $(dirname "$0")/../../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "$APP/source/myx/myx.distro-prepare/sh-lib/MakePrepareDistro.include"

MakePrepareDistro


ListPackageFiles --deep --distro myx --distro ae3 --distro ndm --preset maximal \
	ae3/ae3.web \
	myx/ae3.web.myx-local \
	ndm/com.ndmsystems.ndls \
	ndm/com.ndmsystems.ndss
