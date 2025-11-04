Require ListChangedSourceProjects
# Require ListProjectProvides

MDSC_SOURCE="${MDSC_SOURCE:-$MMDAPP/cache/sources}"

MakeAe3ShareAe3PackagesSources(){
	for projectName in $( ListChangedSourceProjects ) ; do
		local CHECKDIR="$MDSC_SOURCE/$projectName/ae3-packages"
		if [ -d "$CHECKDIR" ] ; then
			find "$CHECKDIR" -mindepth 1 -maxdepth 1 -type d
		fi
	done
}

MakeAe3Share(){
	local SHARE_ROOT="$MMDAPP/output/ae3-share/ae3-distro/common"
	local SRC_LIST="`MakeAe3ShareAe3PackagesSources`"

	local PACKAGES_ALL="$SHARE_ROOT/packages-all"
	mkdir -p "$PACKAGES_ALL"

	echo "copying all changed packages to one folder..."
	local SOURCE_PACKAGE_LIST="`MakeAe3ShareAe3PackagesSources`"
	if test ! -z "$SOURCE_PACKAGE_LIST" ; then
		rsync -rltOoDCi --delete --chmod=ug+rwX $SRC_LIST "$PACKAGES_ALL/" 2>&1 \
		| (grep -v --line-buffered -E '>f\.\.t\.+ ' >&2 || true)
		echo "done." >&2
	else
		echo "ae3 package list is empty!" >&2
	fi 

	cd "$PACKAGES_ALL"
	
	### not in this script:
	
	# local UNPACKED_ALL="$SHARE_ROOT/unpacked-all"
	# mkdir -p "$UNPACKED_ALL"
	
	# echo "copying all resources and settings to unpacked folder..."
	# local UNPACKED_SRC_LIST="`find . -mindepth 2 -maxdepth 2 -type d -name resources -or -name settings`"
	# if test ! -z "$UNPACKED_SRC_LIST" ; then
	# 	rsync  -rltOoDi --delete --chmod=ug+rwX $UNPACKED_SRC_LIST "$UNPACKED_ALL/" 2>&1 \
	#	| (grep -v --line-buffered -E '>f\.\.t\.+ ' >&2 || true)
	# 	echo "done."
	# fi
	
	local AE3_AXIOM="$SHARE_ROOT/ae3-axiom"
	mkdir -p "$AE3_AXIOM"
	
	echo "copying jars to axiom..." >&2
	
	local ALL_JARS_LIST="`find . -mindepth 2 -maxdepth 2 -type d -name jars | sort | sed 's!$!/!'`"
	if test ! -z "$ALL_JARS_LIST" ; then
		rsync -rltOoDi --delete --chmod=ug+rwX $ALL_JARS_LIST "$AE3_AXIOM" 2>&1 \
		| (grep -v --line-buffered -E '>f\.\.t\.+ ' >&2 || true)
		echo "done." >&2
	else
		echo "ae3 jars list is empty!" >&2
	fi
	
	### TARS
	(
		cd "$SHARE_ROOT" ;
		tar -pcjf "$SHARE_ROOT/ae3-axiom.tbz" "ae3-axiom" ;
	) &
	wait
	
	
	### FUCK IT ALL and copy from old workspace 8(((
	# rsync -rltOoDi --delete --chmod=ug+rwX /Volumes/workspace/myx/ae3-share/ae3-distro/common/ $SHARE_ROOT/ 2>&1 \
	#	| (grep -v --line-buffered -E '>f\.\.t\.+ ' >&2 || true)
	rsync -rltOoDi --chmod=ug+rwX /Volumes/workspace/myx/ae3-share/ae3-distro/common/ $SHARE_ROOT/ 2>&1 \
		| (grep -v --line-buffered -E '>f\.\.t\.+ ' >&2 || true)
	
}


MakeAe3Share