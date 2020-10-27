#! /usr/bin/bash

#WORK IN PROGRESS

PREFIX=/mnt/c

#PATH ON WIN 

for i in $(cat list)
do
	#echo $i
	dir=$(echo $i  | cut -f1 -d / | sed 's/\\/\//g' | sed "s|C:|${PREFIX}|g" | sed 's/\[SPACE\]/\ /g')
	name=$(echo $i  | cut -f2 -d /)
	echo $name
	if ls $dir > /dev/null; 
then 
	echo "Dir found"
else 
	mkdir $dir
	fi


lastsavedir=$(ls SAVES/$name |sort  | tail -n 1)


if [ $(diff SAVES/"$name"/"$lastsavedir" "$dir" | grep "Only" | wc -l) == 0 ]
then
	echo "Your last save is the same as this one"
else
	
	cp SAVES/$name/$lastsavedir/ "$dir"/ -r
	echo -e "Game was restored saved"
fi




done
