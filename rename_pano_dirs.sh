#!/bin/zsh
# Prequestities - create all dirs with panoramas!

work_path=$1;
pushd "$work_path"

for f in Новая*
do
	pushd "$f"
	fst=$(ls | head -1 | cut -d '-' -f 2 | cut -d '.' -f 1)
	lst=$(ls | tail -1 | cut -d '-' -f 2 | cut -d '.' -f 1)
	popd
	mv "$f" "$fst"-"$lst"
done

popd;