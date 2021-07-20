#!/bin/zsh

# -depth 1 - VERY IMPORTANT if dir with *.jpg contains other dir with meta info!
# . is default working path for apexec!


work_path=$1
pre_exec=$2
[[ $# -eq 0 ]] && {
	work_path=".";
}
[[ "$pre_exec" == "--pre-exec" ]] && {
	find "$work_path" -type d -depth 1 | while read x
	do
		pushd "$x";
		[ -f meta.txt -o -z meta.txt ] || echo > meta.txt;
		[ -d backup ] || mkdir "backup";
		cp *.jpg backup/
		[[ $? -ne 0 ]] && {
			echo "[ WARNING ] !!! Some photos have NOT been saved to .backup directory!";
		}
		popd
	done
} || { # TODO: check --pre-exec option
	for dir in $(find "$work_path" -type d -depth 1)
	do
		mkpano "$dir";
		[[ $? -eq 0 ]] && { rm -r "$dir/backup/"  };
	done
}