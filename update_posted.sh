#!/bin/zsh

cd /Volumes/Data/ProdCopies"$year"
rm actual/* && find . -type f -not -name '*_posted*' | while read x
do
cp -rv "$x" actual/
done

