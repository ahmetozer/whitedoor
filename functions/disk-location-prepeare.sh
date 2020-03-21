#!/bin/bash
if [[ $LSFDEBUG = "1" ]];
then
	set -x
fi

function disk-location-prepeare() {
		lsblk
    #To getting Disk Name
    while [[ ! $LSFDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]];
    do
      #if the username setted by the envoriment bypass to read username
      if [ -z "$LSFDISKNAME" ]
      then
				echo 'Partition name is like a sda, sdb or vda'
        read -p 'DISK Partition Name » ' -e  LSFDISKNAME
      fi

      #Checking the username pattern
      if [[ $LSFDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]];
      then
        if [ -b /dev/$LSFDISKNAME ];
        then
					if [[ $LSFDISKNAME =~ ^[a-zA-Z0-9._+-]+$ ]] && [ ! -z "$LSFDISKNAME" ];
					then
						echo -e "\e[32mLSFDISKNAME » $LSFDISKNAME\e[39m"
						echo -e "LSFDISKNAME=$LSFDISKNAME" > $VARDIR/LSFDISKNAME
					else
						echo -e "\e[31mError. LSFDISKNAME variable cannot saved\e[39m"
					fi
				else
					echo -e "\e[31mDisk location (/dev/$LSFDISKNAME) cannot found\e[39m"
					LSFDISKNAME=''
        fi
      else
          echo -e "\e[31mYour Share Name has a unexpected char. You can use A-z 0-9 and _- characters\e[39m"
          LSFDISKNAME=''
      fi
    done
}

required_variables=(LSFDISKNAME)
command-help() {
	echo "This script will be set disk variables"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]
then
	disk-location-prepeare
fi
