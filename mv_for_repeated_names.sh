#!/bin/zsh

year=$(date "+%Y");

find /Users/sanya/Data/PhotoDevNew/Export"$year" -name "*_ps*.jpg" -o -name "*Panorama*.jpg" -o -name "*_vid*" | grep -v '__' | while read x

do 
	full_name=$( echo "$x" | tr ' ' '_' )
	mv "$x" "$full_name" 2> /dev/null
	excpt_ext_name=$(echo "$full_name" | cut -d '.' -f 1 | awk -F/ '{print $NF}')
	suffix=$(md5 "$full_name" | cut -d '=' -f 2 | tail -c 4)
	full_path=$(echo "$full_name" | sed 's|\(.*\)/.*|\1|')
	nn=$(echo "$excpt_ext_name" | sed -r 's/_ps/_'"${suffix}"'_ps/g')
	echo Moving "$full_path"/$nn".jpg"
	mv $full_name "$full_path"/$nn".jpg"
done