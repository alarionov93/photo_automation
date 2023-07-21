#!/bin/zsh

ssh alarionov-home touch /tmp/sync 
echo "Waiting for cron job to mount volumes..."
sleep 67

ssh alarionov-home [ -d /media/alex/0_hdd1TB/lost+found ] && {
	rsync -avzu --progress --exclude={'*.tif','backup/','*_vid*','*__.jpg','.DS_Store'} /Users/sanya/Data/PhotoDevNew/ alarionov-home:/media/alex/0_hdd1TB/PhotosLib/2021-2022
	# TODO: here exclude all files, that have _posted duplicates. 
	# Sync only posted - if _posted file has a duplicate without _posted -> remove it from sync list
	for dir in $(ls /Users/sanya/Data | grep ProdCopies)
		do
		echo Syncing /Users/sanya/Data/"$dir";
		# TODO --exclude NOT WORKING!
		rsync -avzu --progress --exclude actual/ /Users/sanya/Data/"$dir" alarionov-home:/media/alex/0_hdd1TB/PhotosLib;
		done
} || {
	echo "[ ERROR ]: 0_hdd1TB is not mounted!"
}
ssh alarionov-home rm /tmp/sync

# Not try to add in rsync only '_ps.jpg' file suffix, save all files exported from lightroom is
# better. Then, you always can delete all non '_ps.jpg' files.
# TODO: automatizations for folder! (e.g. move sync path to script params)

# TODO: check md5 sum

# On destination (server):
# find . -not -name "*tif*" -a -not -name "*__.jpg" -a -not -name ".DS_*" -a -type f -exec md5sum "{}" \; | awk '{print($2" "$1)}'| sort -k 1 > md5_check_dst.txt

# On source: 
# find . -not -name "*tif*" -a -not -name "*__.jpg" -a -not -name ".DS_*" -a -type f -exec md5 "{}" \; | sed s/"MD5 ("// | sed s/")"// | tr -d '=' | sed s/' '/''/ | sort > md5_check.txt
# scp md5_check.txt alarionov-home:/media/alex/0_hdd1TB/PhotosLib/2021-2022/Export2022/
# > ./Export_08_04_22/4235-4262/4235-4262.pto de9363661cdda32c345842dcf8a485c8
# 228d228
# < ./Export_08_04_22/4235-4262/4235-4262.pto de9363661cdda32c345842dcf8a485c8
# 234d233
# < ./Export_08_04_22/4235_4262_Panorama_ps.jpg 0a95ceb6fcb64eb90960f039de39794a
# 235a235
# > ./Export_08_04_22/4235_4262_Panorama_ps.jpg 0a95ceb6fcb64eb90960f039de39794a
# 597d596
# < ./Export_17_06_22/IMG-5118_1_ps.jpg 613d5900231928ab39809093368fb3ab
# 598a598
# > ./Export_17_06_22/IMG-5118_1_ps.jpg 613d5900231928ab39809093368fb3ab
# 612d611
# < ./Export_18_06_22/5239-5240/IMG-5239_1.jpg 5164dcdb1d935969680209ef104aeb26
# 613a613
# > ./Export_18_06_22/5239-5240/IMG-5239_1.jpg 5164dcdb1d935969680209ef104aeb26
# 626d625
# < ./Export_18_06_22/IMG-5195_1_ps.jpg 6b3b56e84f62b1dfed505ae93e718326
# 627a627
# > ./Export_18_06_22/IMG-5195_1_ps.jpg 6b3b56e84f62b1dfed505ae93e718326
# 787,788c787
# < ./md5_check_dst.txt d41d8cd98f00b204e9800998ecf8427e
# < ./md5_check.txt 801614215bcc7c953e52cc9d870ce313
# ---
# > ./md5_check.txt d41d8cd98f00b204e9800998ecf8427e

find . -name "*_ps.*" -o -name "*anorama*" -not -name "*.psd" -not -name "*1500?1000*" | while read x 
do
	convert "$x" -size 1000x1000 -quality 75% /media/alex/0_hdd1TB/for_contest_rgo_ex/$(sha1sum "$x" | cut -d ' ' -f 1)".jpg"
done


