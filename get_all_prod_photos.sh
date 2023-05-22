#!/bin/bash

find . -name "*_ps.*" -o -name "*anorama*" -not -name "*.psd" -not -name "*1500?1000*" | while read x 
do
	convert "$x" -size 1000x1000 -quality 75% /media/alex/0_hdd1TB/for_contest_rgo_ex/$(sha1sum "$x" | cut -d ' ' -f 1)".jpg"
done