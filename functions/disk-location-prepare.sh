#!/bin/bash
if [[ $LSFDEBUG = "1" ]];
then
	set -x
fi

function disk-location-prepare() (
		function main() {

		if [ "$(is-setted-variable LFSDISKNAME)" == true ]
		then
			re-declare-variable LFSDISKNAME
		fi
    	#To getting Disk Name
    	while [[ ! $LFSDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]];
    	do
				lsblk
      	#if the username setted by the envoriment bypass to read username
      	if [ -z "$LFSDISKNAME" ]
      	then
					printf 'Partition name is like a sda, sdb or vda\n'
        	read -p 'DISK Partition Name » ' -e  LFSDISKNAME
      	fi

      	#Checking the username pattern
      	if [[ $LFSDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]];
      	then
        	if [ -b /dev/$LFSDISKNAME ];
        	then
						if [[ $LFSDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]] && [ ! -z "$LFSDISKNAME" ];
						then
							printf "LFSDISKNAME=$LFSDISKNAME" > $VARDIR/LFSDISKNAME
							reload-variable LFSDISKNAME
							disk-size-check
						else
							printf "\e[31mError. LFSDISKNAME variable cannot saved\e[39m"
						fi
					else
						printf "\e[31mDisk location (/dev/$LFSDISKNAME) cannot found\e[39m"
						LFSDISKNAME=''
        	fi
      	else
          	printf "\e[31mDisk location has a unexpected char. You can use A-z 0-9 and _- characters\e[39m"
          	LFSDISKNAME=''
      	fi
    	done
			reload-variable LFSDISKNAME
		echo
		local question
		echo -e "\e[7m\e[5m\e[31mDanger\e[25m\e[39mYou are selectted $LFSDISKNAME disk\e[27m"
	 read -p "Do you want to continue (to continue write yes) » " -e -i no  question
	 if [ "$question" == 'yes' ];
	 then
		 local RESULT
		 printf 'LFSDISKSUCCESSFULLY=5' > $VARDIR/LFSDISKSUCCESSFULLY
		 source $VARDIR/LFSDISKSUCCESSFULLY
		 parted /dev/$LFSDISKNAME -- mklabel GPT
		 RESULT=$?
		 if [ $RESULT -eq 0 ];
		 then
			 LFSDISKSUCCESSFULLY=$((LFSDISKSUCCESSFULLY+1))
		 else
			 echo -e "\e[31mparted /dev/$LFSDISKNAME -- mklabel GPT\e[39m"
		 fi

		 parted /dev/$LFSDISKNAME mkpart BOOT ext2 2048s 150MiB
		 RESULT=$?
		 if [ $RESULT -eq 0 ];
		 then
			 LFSDISKSUCCESSFULLY=$((LFSDISKSUCCESSFULLY+1))
		 else
			 echo -e "\e[31mparted /dev/$LFSDISKNAME mkpart BOOT ext2 2048s 150MiB\e[39m"
		 fi

		 parted /dev/$LFSDISKNAME mkpart ROOT ext4 150MiB 100%
		 RESULT=$?
		 if [ $RESULT -eq 0 ];
		 then
			 LFSDISKSUCCESSFULLY=$((LFSDISKSUCCESSFULLY+1))
		 else
			 echo -e "\e[31mparted /dev/$LFSDISKNAME mkpart ROOT ext4 150MiB 100%\e[39m"
		 fi

		 mkfs -v -t ext2 /dev/$(printf $LFSDISKNAME)1
		 RESULT=$?
		 if [ $RESULT -eq 0 ];
		 then
			 LFSDISKSUCCESSFULLY=$((LFSDISKSUCCESSFULLY+1))
		 else
			 echo -e "\e[31mmkfs -v -t ext2 /dev/$(printf $LFSDISKNAME)1[39m"
		 fi
		 mkfs -v -t ext4 /dev/$(printf $LFSDISKNAME)2
		 RESULT=$?
		 if [ $RESULT -eq 0 ];
		 then
			 LFSDISKSUCCESSFULLY=$((LFSDISKSUCCESSFULLY+1))
		 else
			 echo -e "\e[31mmkfs -v -t ext4 /dev/$(printf $LFSDISKNAME)2\e[39m"
		 fi
		 printf "LFSDISKSUCCESSFULLY=$LFSDISKSUCCESSFULLY" > $VARDIR/LFSDISKSUCCESSFULLY
	 fi

		#statements
		}
		command-help() (
			echo "This script will be set disk variables"
		)

		disk-size-check() (
 		selectted_disk_size=`printf '%s' $(lsblk /dev/$LFSDISKNAME -dbJ -o SIZE | grep size | cut -d'"' -f 4)`
		if [ $selectted_disk_size -gt 30000000000 ];
		then
			echo -e "\e[32m '/dev/$LFSDISKNAME' Disk size is bigger then 30 GB. \e[39m"
		else
			echo -e "\e[31m '/dev/$LFSDISKNAME' Disk size is less then 30 GB. Please select disk whic is bigger than 30 GB.\e[39m"
			export LFSDISKNAME=
			unset-variable LFSDISKNAME
		fi
		)

		source config/main-helper.sh
)

required_variables=(LFSDISKNAME LFSDISKSUCCESSFULLY)



#if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
#then
#	echo asdfsdaf
#	disk-location-prepare
#fi
