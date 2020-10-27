#! /usr/bin/bash

year=$(date | tr -s " " | cut -f6 -d " ")
day=$(date | tr -s " " | cut -f3 -d " ")
month=$(date | tr -s " " | cut -f2 -d " ")
clock=$(date | tr -s " " | cut -f4 -d " ")
hostname=$(hostname)
Backup_Dir_Name=${year}_$day${month}_${clock}_$hostname
echo -e "################################################"
while IFS= read -r i
do
  	Game_Name=$(echo $i | cut -d "~" -f1)
  	Save_Location=$(wslpath -a "$(echo $i | cut -d "~" -f2)")
	
	mkdir SAVES/$Game_Name/ 2> /dev/null	
	
	if [[ $(ls -la SAVES/$Game_Name | wc -l) -eq 3 ]];
	then
		echo -e "\e[48;5;93mCreating the first save for $Game_Name was successful\e[0m"
		mkdir -p SAVES/$Game_Name/$Backup_Dir_Name
		cp -r "$Save_Location"/*  SAVES/$Game_Name/$Backup_Dir_Name
	else
		Last_Save=$(ls SAVES/$Game_Name | sort  | tail -n 1 | tr -s " " | cut -f9 -d " ")
		
		
		ls "$Save_Location" &> /dev/null
		if [[ $? -gt 0 ]];
		then
			echo -e "\e[48;5;88m$Game_Name has no saves on your computer\e[0m"
		else
			num_of_differences=$(diff -r "SAVES/$Game_Name/$Last_Save" "$Save_Location" | grep "Only" | wc -l)

			if [[ $num_of_differences == 0 ]];
			then
				echo -e "\e[48;5;33mThe last save is identical with the current one for $Game_Name\e[0m"
			else			
				mkdir -p $Backup_Dir_Name
				
				cp -r "$Save_Location"  SAVES/$Game_Name/$Backup_Dir_Name
				echo -e "\e[48;5;28mDifferent saves for $Game_Name\e[0m"
			fi 
		fi
	fi
	echo -e "################################################"

done < list



