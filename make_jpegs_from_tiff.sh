#!/bin/zsh


work_path=$1;
cd "$work_path"

for dir in $(find . -type d -depth 1)
do 
	pushd "$dir"
	# the path below is used relying on pano_tool.sh:61 or 66 line! 
	# @Underscore in .jpg filename should save me if "_ps" was not added after Photoshop processing
	convert "results/$(basename "$work_path/$dir")"_Panorama.tif "../$(basename "$work_path/$dir")"_Panorama__.jpg
	popd
done