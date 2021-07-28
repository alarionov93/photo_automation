#!/bin/zsh

year=$(date "+%Y");
mkdir /Volumes/Data/ProdCopies"$year";

#mkfifo aaa
#/bin/zsh sync_photos.sh

lst=()
find /Volumes/Data/PhotoDevNew/Export"$year" -name "*_ps*.jpg" -o -name "*Panorama*.jpg" | while read x
do 
	nn=$( echo "$x" | tr ' ' '_' )
	mv "$x" "$nn" 2> /dev/null
	lst+=( "$nn" )
done 

rsync -Pvu $lst /Volumes/Data/ProdCopies"$year"/;

#cat prod.list | grep ' ' | while read x
#do
#        first=$(echo $x | cut -d ' ' -f 1 | awk -F '\\./' '{print($2)}');
#        second=$(echo $x | cut -d ' ' -f 2);
#        echo mv "$first\ $second" "$first"_"$second";
#done
