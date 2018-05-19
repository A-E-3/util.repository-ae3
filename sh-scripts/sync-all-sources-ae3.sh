#!/usr/bin/env bash

if [ -z "$APP" ] ; then
	set -e
	APP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "$APP/source/myx/util.repository-myx/sh-lib/syncing.sh.include"

async gitSync "ae3/util.repository-ae3/"	           "git@github.com:A-E-3/util.repository-ae3.git"

async gitSync "ae3/ae3-install-utility/"	           "git@github.com:A-E-3/ae3-install-utility.git"

# async gitSync "myx/clean-boot/"  "git@github.com:myx/clean-boot.git"
# async gitSync "myx/clean-jdbc.util/"  "git@github.com:myx/clean-jdbc.util.git"
# async gitSync "myx/clean-yaumnrc/"  "git@github.com:myx/clean-yaumnrc.git"

INF="$APP/source/ae3/util.repository-ae3/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$APP/source/ae3/repository.inf"

wait
