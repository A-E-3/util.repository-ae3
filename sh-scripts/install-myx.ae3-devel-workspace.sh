#!/usr/bin/env bash

####
## Note: this is a special script that is designed to run stand-alone
##        (no location on local file-system) and on unprepared unix machine. 
####

WorkspaceBootstrap() {
	bash -ec 'bash -e <(
		url='https://raw.githubusercontent.com/myx/myx.distro-.local/refs/heads/main/sh-scripts/workspace-install.sh'
		command -v curl >/dev/null 2>&1 && curl -fsSL "$url" && exit 0
		command -v fetch >/dev/null 2>&1 && fetch -q -o - "$url" && exit 0
		command -v wget >/dev/null 2>&1 && wget -qO- "$url" && exit 0
		echo "⛔ ERROR: need curl, fetch or wget" >&2; exit 1
	) "$@"' -- "$@"
}

export TGT_APP_PATH="${TGT_APP_PATH:-~/Workspaces/ws-myx.ae3-devel}"

WorkspaceBootstrap --verbose --git-clone --config-stdin \
<<'WORKSPACE_CONFIG'

    ## Workspace config for: ae3/util.workspace-ae3.devel ##

    # Repository roots for source projects:
		source root ae3
        source root lib
		source root myx

    # Initial list of source projects to pull
		source pull ae3/util.repository-ae3:master:git@github.com:A-E-3/util.repository-ae3.git

    # Executable commands to setup source sub-system
		deploy exec env | grep MD ; echo '👋 Deploy Hello!'
		source exec env | grep MD ; echo '👋 Source Hello!'
		#source exec Source DistroImageSync --verbose --all-tasks --execute-source-prepare-pull

WORKSPACE_CONFIG
