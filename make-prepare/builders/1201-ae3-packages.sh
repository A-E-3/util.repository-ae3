
if [ "`type -t ListChangedSourceProjects`" != "function" ] ; then
. "$MMDAPP/source/myx/myx.distro-prepare/sh-scripts/list-changed-source-projects.sh"
fi
if [ "`type -t ListCachedProjectProvides`" != "function" ] ; then
. "$MMDAPP/source/myx/myx.distro-prepare/sh-scripts/list-cached-project-provides.sh"
fi

MakeCachedProjectAe3Packages(){
	local PKG="${1#$MMDAPP/source/}"
	if [ -z "$PKG" ] ; then
		echo "MakeCachedProjectAe3Packages: 'PKG' argument is required!" >&2 ; exit 1
	fi

	local DIR="$MMDAPP/cached/source/$PKG"
	local SRC="$DIR/ae3-packages"
	if test ! -d "$SRC" ; then
		echo "Project doesn't have ae3-packages" >&2
		exit 1
	fi
	
	local AE3PKGS="`find "$SRC" -mindepth 1 -maxdepth 1 -type d | sort`"
	if test -z "$AE3PKGS" ; then
		return 0
	fi
	
	echo "packing ae3 packages..."
	for AE3PKG in $AE3PKGS ; do
		if test -f "$AE3PKG/package.json" ; then
			echo "tarring: $AE3PKG..." >&2
			( cd "$AE3PKG" ; Async "`basename "$AE3PKG"`" tar -pczv -f "$MMDAPP/output/distro/$PKG/`basename "$AE3PKG"`.tar.gz" * ; wait ) &
		else
			echo "skipping: $AE3PKG, no package.json" >&2
		fi
	done
	wait
	echo "done."
}

MakeChangedAe3Packages(){
	for PKG in `ListChangedSourceProjects` ; do
#		if test ! -z "`ListCachedProjectProvides "$PKG" "build-prepare" | grep -e "^ae3-packages$"`" ; then
			local CHECKDIR="$MMDAPP/cached/source/$PKG/ae3-packages"
			if test -d "$CHECKDIR" ; then
				Async -2 MakeCachedProjectAe3Packages "$PKG"
				wait
			fi
#		fi
	done
}

MakeChangedAe3Packages