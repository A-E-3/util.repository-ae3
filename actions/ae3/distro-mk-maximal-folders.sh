#!/bin/sh

[ -d "$MMDAPP/source" ] || ( echo "ERROR: expecting 'source' directory." >&2 && exit 1 )

. "$MMDAPP/source/myx/myx.distro-source/sh-lib/MakePrepareDistro.include"

MakePrepareDistro


ListPackageFiles --deep --distro myx --distro ae3 --distro ndm --preset maximal \
	ae3/ae3.web \
	myx/ae3.web.myx-local \
	ndm/cloud-ndxs/ndss-ae3-service \
	ndm/cloud-ndxs/ndss-ae3-service
