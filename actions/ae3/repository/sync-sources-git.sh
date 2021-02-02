#!/bin/sh

[ -d "$MMDAPP/source" ] || ( echo "ERROR: expecting 'source' directory." >&2 && exit 1 )

. "$MMDAPP/source/ae3/util.repository-ae3/sh-scripts/sync-all-sources-ae3.sh"
