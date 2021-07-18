#!/bin/zsh
# dir with JPG files for panorama sholud be named properly - panorama gets its name after stiching!

#
## Simple usage:
## -depth 1 - VERY IMPORTANT if dir with *.jpg contains other dir with meta info!
# find ./Export_13_07_21 -type d -depth 1 | while read dir
# do
# 	mkpano "$dir";
# done
#

# TODO: mkdir with temp JPGs sources!!!
# FIXME: choose options loop NOT WORKING if execute script as in example above!!!

if [[ $# -eq 0 ]]; then
	echo "Path to working directory not passed!";
	exit -1;
fi
work_path=$1;
proj_name="$(basename $work_path).pto";
full_proj_name="$work_path/$proj_name";

pushd $work_path;

# Check if *_Panorama files exist already
exist=$(ls | grep _Panorama | wc -l);
echo $exist;
add_prefix=0;
if [[ $exist -eq 1 ]]; then
	echo "Panorama exists! Check options\nWhat do you wish to do: (A)bort, (R)eassemble with different filename, (O)verwrite";
	read answer;
    case "$answer" in
        [Aa]* ) exit -2; break;;
        [Rr]* ) add_prefix=1; break;;
        [Oo]* ) echo "Overwriting $full_proj_name"; break;;
        # [Ss]* ) echo "add_prefix=0"; break;;
        # * ) echo "Please, choose from existing options!";;
    esac
fi

# pto_gen -o "$proj_name" *.jpg

# cpfind --multirow -o "$proj_name" "$proj_name"

# celeste_standalone -i "$proj_name" -o "$proj_name"

# cpclean -o "$proj_name" "$proj_name"

# autooptimiser -a -l -s -m -o "$proj_name" "$proj_name"

# pano_modify --canvas=AUTO --crop=AUTO -o "$proj_name" "$proj_name"

# nona -o "out" "$proj_name"

# n=0;
# imgs="";
# for f in *.tif
# do
# 	n=$((n + 1));
# 	imgs+=( "$f" );
# done

# echo "$imgs";

# enblend -o "$(basename $work_path)"_Panorama.jpg $imgs
popd


