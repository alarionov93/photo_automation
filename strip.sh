#!/bin/zsh

for f in $(find . -type f)
do 
	mv "$f" $(echo "$f" | tr ' ' '_')
done

