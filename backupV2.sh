#! /usr/bin/bash

year=$(date | tr -s " " | cut -f6 -d " ")
day=$(date | tr -s " " | cut -f3 -d " ")
month=$(date | tr -s " " | cut -f2 -d " ")
clock=$(date | tr -s " " | cut -f4 -d " ")
hostname=$(hostname)
Backup_Dir_Name=${year}_$day${month}_${clock}_$hostname

while IFS= read -r i
do
  	Game_Name=$(echo $i | cut -d "~" -f1)
  	Save_Location=$(wslpath -a "$(echo $i | cut -d "~" -f2)")
	
	mkdir SAVES/$Game_Name/ 2> /dev/null
	cd SAVES/$Game_Name/
	
	
	
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

done < list



