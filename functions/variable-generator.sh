#!/bin/bash
variable-generate() {
	for i in "${required_variables[@]}";
	do
		printf "\t"
		FILE=$VARDIR/$i
		if [ -f "$FILE" ]; then
    	printf "$i already exist "
			show-variable $i
		else
    	printf "$i does not exist. Creating\n"
			echo "$i="> $VARDIR/$i
		fi
	done
}

function variable-generator() {
	mkdir -p  $VARDIR
	echo Generating VARIABLES
	local FILES=$ProjectDIR/functions/*
	for f in $FILES
	do
		local basename=$(basename $f)
		echo Generating variable for $basename function
		source $f
		variable-generate
		unset required_variables
	done
}
if [[ $_ == $0 ]]
then
	if [ ! -z "$required_variables" ];
	then
		variable-generate
	else
		variable-generator
	fi
fi
