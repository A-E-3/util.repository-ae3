#!/usr/bin/env bash

if [ -z "$MMDAPP" ] ; then
	set -e
	export MMDAPP="$( cd $(dirname "$0")/../../../.. ; pwd )"
	echo "$0: Working in: $MMDAPP"  >&2
	[ -d "$MMDAPP/source" ] || ( echo "ERROR: expecting 'source' directory." >&2 && exit 1 )
fi

. "`myx.common which lib/async`"
. "`myx.common which git/cloneSync`"

async(){
	Async -2 GitCloneSync "$MMDAPP/source/$@"
	# Async -3 myx.common git/cloneSync "$MMDAPP/source/$@"
}

async "ae3/util.repository-ae3/"				"git@github.com:A-E-3/util.repository-ae3.git"

async "ae3/ae3-install-utility/"				"git@github.com:A-E-3/ae3-install-utility.git"

wait

async "ae3/ae3.api/"	 						"git@github.com:A-E-3/ae3.api.git"
async "ae3/ae3.sdk/"	 						"git@github.com:A-E-3/ae3.sdk.git"

wait

async "ae3/ae3-plug-iface-logger/"				"git@github.com:A-E-3/ae3-plug-iface-logger.git"
async "ae3/ae3-plug-iface-ssh/"					"git@github.com:A-E-3/ae3-plug-iface-ssh.git"

async "ae3/ae3.sdk-lang.acm-tpl/"				"git@github.com:A-E-3/ae3.sdk-lang.acm-tpl.git"
async "ae3/ae3.sys.pkg.base/"					"git@github.com:A-E-3/ae3.sys.pkg.base.git"

async "ae3/ae3.sys.pkg.i3.net/"					"git@github.com:A-E-3/ae3.sys.pkg.i3.net.git"
async "ae3/ae3.sys.pkg.i3.web/"					"git@github.com:A-E-3/ae3.sys.pkg.i3.web.git"

async "ae3/ae3.sys.pkg.l2.tgt.xml"				"git@github.com:A-E-3/ae3.sys.pkg.l2.tgt.xml.git"

wait

async "ae3/ae3.sys.pkg.s4"						"git@github.com:A-E-3/ae3.sys.pkg.s4.git"
async "ae3/ae3.sys.pkg.s4.lcl.bdbje"			"git@github.com:A-E-3/ae3.sys.pkg.s4.lcl.bdbje.git"

async "ae3/ae3.pkg.net.ndm.client/"				"git@github.com:A-E-3/ae3.pkg.net.ndm.client.git"


async "ae3/ae3.dev.tgt.xml"						"git@github.com:A-E-3/ae3.dev.tgt.xml.git"

wait

INF="$MMDAPP/source/ae3/util.repository-ae3/data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$MMDAPP/source/ae3/repository.inf"
