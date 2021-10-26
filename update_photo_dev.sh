#!/bin/zsh

ssh alarionov-home touch /tmp/sync 
echo "Waiting for cron job to mount volumes..."
sleep 67

ssh alarionov-home [ -d /media/alex/0_hdd1TB/lost+found ] && {
	rsync -avzu --progress --exclude={'*.tif','backup/','*_vid*','*__.jpg','.DS_Store'} /Volumes/Data/PhotoDevNew/ alarionov-home:/media/alex/0_hdd1TB/PhotosLib/2020-2021
	for dir in $(ls /Volumes/Data | grep ProdCopies)
		do
		echo Syncing /Volumes/Data/"$dir";
		rsync -avzu --progress /Volumes/Data/"$dir" alarionov-home:/media/alex/0_hdd1TB/PhotosLib;
		done
} || {
	echo "[ ERROR ]: 0_hdd1TB is not mounted!"
}
ssh alarionov-home rm /tmp/sync

# Not try to add in rsync only '_ps.jpg' file suffix, save all files exported from lightroom is
# better. Then, you always can delete all non '_ps.jpg' files.
# TODO: automatizations for folder! (e.g. move sync path to script params)
