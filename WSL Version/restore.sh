#! /usr/bin/bash

while IFS= read -r i
do
  	Game_Name=$(echo $i | cut -d "~" -f1)
  	Save_Location=$(wslpath -a "$(echo $i | cut -d "~" -f2)")
	Last_Save=$(ls SAVES/$Game_Name | sort  | tail -n 1 | tr -s " " | cut -f9 -d " ")
	echo $Save_Location $Game_Name $Last_Save


		ls "$Save_Location" &> /dev/null
		if [[ $? -gt 0 ]];
		then
			mkdir -p "$Save_Location" &> /dev/null
			cp "SAVES/$Game_Name/$Last_Save"/* "$Save_Location" -r
			echo -e "\e[48;5;88m$Game_Name had no saves on your computer. \e[0m"
		else

			if [[ $(diff "SAVES/$Game_Name/$Last_Save" "$Save_Location" | grep "Only" | wc -l) == 0 ]];
			then
				echo -e "\e[48;5;33mThe last save is identical with the current one for $Game_Name\e[0m"
			else			
				mkdir -p "$Save_Location" &> /dev/null
				rm -r "$Save_Location"/* &> /dev/null
				cp "SAVES/$Game_Name/$Last_Save"/* "$Save_Location" -r
				echo -e "\e[48;5;28mDifferent saves for $Game_Name\e[0m"
			fi 
		fi
	echo -e "################################################"

	
break
done < list


