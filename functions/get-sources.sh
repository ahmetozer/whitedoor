#!/bin/bash
function control-sources() {
	printf "Controling Sources\n"
	local source_count downloaded_count
	source_count=0
	downloaded_count=0
	while IFS= read -r line
	do
	if [ "${#line}" -gt 3 ]
	then
		if [ -f "$DOWNLOAD_DIR/$(basename $line)" ]
		then
			echo -e "\e[32m$line is downloaded\e[39m"
		else
			echo -e "\e[31m$line is not downloaded\e[39m"
		fi
		source_count=$((source_count+1))
	fi
	done < $DOWNLOAD_DIR/wget-list
	source_count=$((source_count+1)) #To add wget-list

	for f in $DOWNLOAD_DIR/*
	do		downloaded_count=$((downloaded_count+1))
	done
 	echo "source_count=$source_count downloaded_count=$downloaded_count"
	if [ "$source_count" == "$downloaded_count" ]
	then
		echo -e "\e[32mAll files downloaded\e[39m"
	else
		echo -e "\e[31mSome files is missing\e[39m"
	fi
}
function get-sources() {
	if is-mounted-lfs
	then
		mkdir $LFS/sources
		wget http://www.linuxfromscratch.org/lfs/view/stable/wget-list -O $LFS/sources/wget-list
		wget --input-file=$LFS/sources/wget-list --continue --directory-prefix=$LFS/sources
	else
		echo -e "\e[31mPlease mount LFS system with mount-lfs command\e[32m"
	fi
}
