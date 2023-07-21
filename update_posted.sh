#!/bin/zsh

cd /Volumes/Data/ProdCopies"$year"
rm actual/* && find . -type f -not -name '*_posted*' | while read x
do
cp -rv "$x" actual/
done

# Make all _ps photos _posted

# find . -name "*_ps*" | while read x
# do
# nn=$(echo "$x" | sed -r 's/_ps/_ps_posted/g')
# mv "$x" "$nn"
# done