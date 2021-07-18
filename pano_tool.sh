#!/bin/zsh
# dir with JPG files for panorama sholud be named properly - panorama gets its name after stiching!

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
if [[ $exist -eq 1 ]]; then
	echo "Panorama exists! Check options below:";
	read -p "What do you wish to do? (A)bort, (R)eassemble, (S)kip only this panorama generating ?" answer
    case $answer in
        [Ss]* ) nn_; break;;
        [Rr]* ) exit;;
        * ) echo "";;
    esac
	exit -1;
fi

pto_gen -o "$proj_name" *.jpg

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

echo "$imgs";

enblend -o "$(basename $work_path)"_Panorama.jpg $imgs
popd


