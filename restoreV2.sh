#! /usr/bin/bash

while IFS= read -r i
do
  	Game_Name=$(echo $i | cut -d "~" -f1)
  	Save_Location=$(wslpath -a "$(echo $i | cut -d "~" -f2)")
	
	mkdir SAVES/$Game_Name/ 2> /dev/null
	cd SAVES/$Game_Name/
	
	echo '''
	
	pwd
	if [[ $(ls -la | wc -l) -eq 3 ]];
	then
		echo "Director gol"
		mkdir -p $Backup_Dir_Name
		cp -r "$Save_Location"/*  $Backup_Dir_Name
	else
		echo "Directorul contine ceva????. Se vor compara directoarele"
		Last_Save=$(ls | sort  | tail -n 1 | tr -s " " | cut -f9 -d " ")
		
		if [[ $(diff "$Last_Save" "$Save_Location" | grep "Only" | wc -l) == 0 ]];
		then
			echo "Ultima salvare este identica cu cea curenta"
		else			
			mkdir -p $Backup_Dir_Name
			cp -r "$Save_Location"/*  $Backup_Dir_Name
			echo "Salvari diferite"
		fi 
	fi
	''' > /dev/null
done < list





echo '''

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
''' > /dev/null