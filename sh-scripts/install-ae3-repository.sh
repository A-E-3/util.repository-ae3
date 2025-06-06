#!/bin/sh

####
## Note: this is a special script that is designed 
##       to run stand-alone (no location on local 
##       file-system) and on un-prepared OS. 
####

TGT_APP_PATH="${TGT_APP_PATH:-$1}"
test -z "$TGT_APP_PATH" && echo "ERROR: 'TGT_APP_PATH' env must be set" >&2 && exit 1

##########################
echo "Installing myx.common"

FetchStdout(){
	local URL="$1"
	[ -z "$URL" ] && echo "ERROR: FetchStdout: The URL is required!" >&2 && exit 1
	set -e

	if [ ! -z "`which curl || true`" ]  ; then curl --silent -L $URL  ; return 0 ; fi
	if [ ! -z "`which fetch || true`" ] ; then fetch -o - $URL        ; return 0 ; fi
	if [ ! -z "`which wget || true`" ]  ; then wget --quiet -O - $URL ; return 0 ; fi

	echo "ERROR: curl, fetch or wget were not found, do not know how to download!" >&2
	exit 1
}

FetchStdout https://raw.githubusercontent.com/myx/os-myx.common/master/sh-scripts/install-myx.common.sh -o - | sh -e

myx.common lib/installEnsurePackage bash git || true

###########################################################
echo "Installing AE3 repository into: $TGT_APP_PATH"

export MMDAPP="$TGT_APP_PATH"

myx.common git/cloneSync "$MMDAPP/source/ae3/util.repository-ae3" "git@github.com:A-E-3/util.repository-ae3.git"

INF="$MMDAPP/source/ae3/util.repository-ae3/sh-data/repository/repository.inf"
( set -e ; echo "# copied from $INF at `date`" ; cat "$INF" ) > "$MMDAPP/source/ae3/repository.inf"

############
echo "Done."