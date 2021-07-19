#!/bin/zsh
# dir with JPG files for panorama sholud be named properly - panorama gets its name after stiching!

#
## Simple usage:
## apexec /path/to/working/dir
# . is default path to working dir for apexec!
# assembling_pano_executor.sh

# TODO: mkdir with temp JPGs sources!!!
# FIXME: not open panorama jpg files while reassembling!!!

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
add_prefix=0;
overwrite=0;
if [[ $exist -eq 1 ]]; then
	echo "Panorama ${work_path} exists! Check options below.\nWhat do you wish to do: (S)kip, (R)eassemble with different filename, (O)verwrite";
	read answer;
    case "$answer" in
        [Ss]* ) echo "Skipping $full_proj_name";exit -2; ;;
        [Rr]* ) echo "Reassembling $full_proj_name";add_prefix=1; ;;
        [Oo]* ) echo "Overwriting $full_proj_name";overwrite=1; ;;
        # [Ss]* ) echo "add_prefix=0"; break;;
        * ) echo "Please, choose from existing options!";;
    esac
fi
echo "Working..";

[ -f meta.txt -a -z meta.txt ] && fov="--fov "$(cat meta.txt)

pto_gen -o "$fov" --projection 0 "$proj_name" *.jpg

cpfind --multirow -o "$proj_name" "$proj_name"

celeste_standalone -i "$proj_name" -o "$proj_name"

cpclean -o "$proj_name" "$proj_name"

autooptimiser -a -l -s -m -o "$proj_name" "$proj_name"

pano_modify --canvas=AUTO --crop=AUTO -o "$proj_name" "$proj_name"

nona -o "out" "$proj_name"

n=0;
imgs="";
for f in *.tif
do
	n=$((n + 1));
	imgs+=( "$f" );
done

# echo "$imgs";
[[ "$add_prefix" -eq 0 ]] && {
	echo Creating/replacing panorama "$(basename $work_path)"_Panorama.jpg;
	enblend -o "$(basename $work_path)"_Panorama.jpg $imgs
}
[[ "$add_prefix" -eq 1 ]] && {
	prefix=$(date "+%s");
	echo Reassebling panorama "$(basename $work_path)"_"$prefix"_Panorama.jpg
	enblend -o "$(basename $work_path)"_"$prefix"_Panorama.jpg $imgs
}
popd


