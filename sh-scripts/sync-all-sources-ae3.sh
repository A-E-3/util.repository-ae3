#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/source" ] || ( echo "expecting 'source' directory." >&2 && exit 1 )
fi

. "`myx.common which lib/async`"
. "`myx.common which lib/gitCloneSync`"

async(){
	Async -2 GitCloneSync "$MMDAPP/source/$@"
}

async "ae3/util.repository-ae3/"	           "git@github.com:A-E-3/util.repository-ae3.git"

async "ae3/ae3-install-utility/"	           "git@github.com:A-E-3/ae3-install-utility.git"

wait

INF="$MMDAPP/source/ae3/util.repository-ae3/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$MMDAPP/source/ae3/repository.inf"
