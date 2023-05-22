#!/bin/zsh

year=$(date "+%Y");
# "$year" first letter is T!!!
mkdir /Volumes/Data/ProdCopies"$year";

#/bin/zsh sync_photos.sh
# [ WARNING!!! ] _posted prefix should appear in ProdCopies, thats why 
# [ WARNING!!! ] YOU NEVER SHOULD REMOVE FILES FROM ProdCopies once its createD!

lst=()
find /Volumes/Data/PhotoDevNew/Export"$year" -name "*_ps*.jpg" -o -name "*Panorama*.jpg" -o -name "*_vid*" | grep -v '__' | while read x
do 
	full_name=$( echo "$x" | tr ' ' '_' )
	mv "$x" "$full_name" 2> /dev/null
	excpt_ext_name=$(echo "$full_name" | cut -d '.' -f 1 | awk -F/ '{print $NF}')
	[ -f /Volumes/Data/ProdCopies"$year"/$excpt_ext_name"_posted.jpg" ] && { 
		echo /Volumes/Data/ProdCopies"$year"/$excpt_ext_name"_posted.jpg is already there!"
	} || {
		echo "Adding $full_name;"
		lst+=( "$full_name" )
	}
	# lst+=( "$full_name" )
done

rsync -IPv $lst /Volumes/Data/ProdCopies"$year"/;

cd /Volumes/Data/ProdCopies"$year"
rm actual/* && find . -type f -not -name '*_posted*' | while read x
do
	cp -rv "$x" actual/
done

#cat prod.list | grep ' ' | while read x
#do
#        first=$(echo $x | cut -d ' ' -f 1 | awk -F '\\./' '{print($2)}');
#        second=$(echo $x | cut -d ' ' -f 2);
#        echo mv "$first\ $second" "$first"_"$second";
#done
