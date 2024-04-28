#!/bin/bash

find "$1" -type f | while read f;
do
	count=1
	copy=$(basename $f)

	while [ -f $2/$copy ];
	do
		copy=$(basename ${f%.*}$count).${f##*.}
		count=$(($count + 1))
	done

	copy=$2/$copy
	cp $f $copy
done
