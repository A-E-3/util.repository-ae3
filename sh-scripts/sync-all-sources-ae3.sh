#!/usr/bin/env bash

if [ -z "$APP" ] ; then
	set -e
	APP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $APP"  >&2
	[ -d "$APP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "`myx.common which lib/async`"
. "`myx.common which lib/gitCloneSync`"

async(){
	Async -2 GitCloneSync "$@"
}

async "ae3/util.repository-ae3/"	           "git@github.com:A-E-3/util.repository-ae3.git"

async "ae3/ae3-install-utility/"	           "git@github.com:A-E-3/ae3-install-utility.git"

wait

INF="$APP/source/ae3/util.repository-ae3/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$APP/source/ae3/repository.inf"
