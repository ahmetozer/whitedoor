#!/bin/bash
function variable-generate() {
		FILE=$VARDIR/$1
		if [ -f "$FILE" ]; then
    	printf "$1 already exist "
			show-variable $1
			echo
		else
    	printf "$1 does not exist. Creating"
			printf "$(basename $1)=$2"> $VARDIR/$1
			reload-variable $1
		fi
}

function variable-generator() {
	mkdir -p  $VARDIR
	echo Generating VARIABLES
	local FILES=$ProjectDIR/functions/*
	for f in $FILES
	do
		local basename=$(basename $f)
		printf "Generating variable for $basename function\n"
		source $f
		for i in "${required_variables[@]}";
		do
			printf "\t"
			variable-generate $i
		done
		unset required_variables
	done
}
if [[ $_ == $0 ]]
then
	if [ ! -z "$required_variables" ];
	then
		for i in "${required_variables[@]}";
		do
			printf "\t"
			variable-generate $i
		done
	else
		variable-generator
	fi
fi
