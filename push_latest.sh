#!/bin/sh


ps h -p $$ # show info about proccess for current PID
printf \\U0001f4a9\\r\\n | hexdump
base_v=v0.0.
# commit and push to git
git add *
echo "Enter commit msg and press [ENTER]: "
read msg
git commit -a -m "$msg ..and fix some \xf0\x9f\x92\xa9"
echo "..and fix some \xf0\x9f\x92\xa9"
git push
[ $? -eq 0 ] && {
	ver_num=$(cat version.txt | tail -1)
	git tag "$base_v"$((ver_num+1))
	git push --tags
	echo $((ver_num+1)) >> version.txt
	echo "That's \xf0\x9f\xa4\x98!"
	echo "Let's drink some vodka with \xf0\x9f\x8d\xba!"
} || {
	echo "[ERROR]: git push command was unsuccessful!"
}