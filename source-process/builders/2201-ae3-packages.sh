MakeCachedProjectAe3Packages(){
	local MDSC_SOURCE="${MDSC_SOURCE:-$MMDAPP/cached/sources}"
	local MDSC_OUTPUT="${MDSC_OUTPUT:-$MMDAPP/output/distro}"
	
	local projectName="$1"
	if [ -z "$projectName" ] ; then
		echo "ERROR: MakeCachedProjectAe3Packages: 'projectName' argument is required!" >&2 ; exit 1
	fi

	local DIR="$MDSC_SOURCE/$projectName"
	local SRC="$DIR/ae3-packages"
	if [ ! -d "$SRC" ] ; then
		echo "ERROR: Project doesn't have ae3-packages" >&2 ; return 1
	fi
	
	local AE3PKGS="`find "$SRC" -mindepth 1 -maxdepth 1 -type d | sort`"
	if [ -z "$AE3PKGS" ] ; then
		return 0
	fi
	
	echo "packing ae3 packages..."
	for AE3PKG in $AE3PKGS ; do
		if test -f "$AE3PKG/package.json" ; then
			echo "tarring: $AE3PKG..." >&2
			mkdir -p "$MDSC_OUTPUT/$projectName"
			( \
				cd "$AE3PKG"
				Async "`basename "$AE3PKG"`" \
					tar \
						-pczv \
						--exclude='.DS_Store' \
						--exclude='Icon?' \
						--exclude='._*' \
						--exclude='.Spotlight-V100' \
						--exclude='.Trashes' \
						--exclude='.git' \
						--exclude='.git/**' \
						--exclude='CVS' \
						$( if tar --version 2>/dev/null | grep -q GNU ; then echo "--no-xattrs --no-acls --no-selinux"; fi ) \
						$( if tar --version 2>/dev/null | grep -qi bsdtar ; then echo "--disable-copyfile"; fi ) \
						-f "$MDSC_OUTPUT/$projectName/`basename "$AE3PKG"`.tar.gz" *
				wait
			) &
		else
			echo "skipping: $AE3PKG, no package.json" >&2
		fi
	done
	wait
	echo "done."
}

Require ListDistroProvides
ListDistroProvides --select-changed --filter-and-cut "source-process" | grep -e " ae3-packages$" \
| cut -d" " -f1 | while read -r projectName ; do
	if [ -d "$MDSC_SOURCE/$projectName/ae3-packages" ] ; then
		Async -2 MakeCachedProjectAe3Packages "$projectName"
		wait
	else
		echo "skipping: $projectName, no ae3-packages folder" >&2
	fi
done
