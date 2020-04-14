function mount-lfs() {
	mkdir -p $LFS
	mount -v -t ext4 /dev/$(printf $LFSDISKNAME)2 $LFS
	mkdir -p $LFS/boot
	mount -v -t ext2 /dev/$(printf $LFSDISKNAME)1 $LFS/boot
}

function is-mounted-lfs() {
	source $VARDIR/LFSDISKSUCCESSFULLY
	if [ "$LFSDISKSUCCESSFULLY" == 0 ]
	then
		if mount -l | grep " $LFS " > /dev/null
		then
			if mount -l | grep " $LFS/boot " > /dev/null
			then
				return 0
			else
				echo -e "\e[31mLFS boot dir not fount. Please mount LFS disk with mount-lfs command\e[32m"
				return 1
			fi
		else
			echo -e "\e[31mLFS dir not found.Please mount LFS disk with mount-lfs command\e[32m"
			return 1
		fi
	else
		echo -e "\e[31mPlease prepare disk system with disk-location-prepare command\e[32m"
		return 1
	fi
}
