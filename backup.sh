#! /usr/bin/bash



PREFIX=/mnt/c

#PATH ON WIN 

year=$(date | tr -s " " | cut -f6 -d " ")
day=$(date | tr -s " " | cut -f3 -d " ")
month=$(date | tr -s " " | cut -f2 -d " ")
clock=$(date | tr -s " " | cut -f4 -d " ")
hostname=$(hostname)
dirname=${year}_$day${month}_${clock}_$hostname
for i in $(cat list)
do
	#echo $i
	dir=$(echo $i  | cut -f1 -d / | sed 's/\\/\//g' | sed "s|C:|${PREFIX}|g" | sed 's/SPACE/\ /g')
	name=$(echo $i  | cut -f2 -d /)
	echo $name
	if ls SAVES/$name > /dev/null; 
then 
	echo "Dir found"
else 
	mkdir SAVES/$name
	fi

#echo $name $dir

#de comparat ultima salvare inainte de copiere
lastsavedir=$(ls SAVES/$name |sort  | tail -n 1 | tr -s " " | cut -f9 -d " ")

#echo SAVES/$name/$lastsavedir
#echo $dir

if [ $(diff SAVES/"$name"/"$lastsavedir" "$dir" | grep "Only" | wc -l) == 0 ] #ceva gresit aici
then
	echo "Your last save is the same as this one"
else
	mkdir SAVES/$name/$dirname
	cp "$dir"/* SAVES/$name/$dirname/ -r
	#echo -e $dir SAVES/$name/$dirname
	echo -e "Game was successfully saved"
fi




done

#git push