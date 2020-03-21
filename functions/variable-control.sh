
function reload-variables() {
	source $VARDIR/*
}

function show-variables() {
FILES=$VARDIR/*
reload-variables
for f in $FILES
do
	basename=$(basename $f)
	tmp_variable=${!basename}
	if [ ${#tmp_variable} == 0 ];
	then
		echo -e "\e[39m$basename=${!basename}\e[39m"
	else
		echo -e "\e[32m$basename=${!basename}\e[39m"
	fi
done
}

function reload-variable() {
	if [ -f $VARDIR/$1 ];
	then
		source $VARDIR/$1
		echo -e "\e[32m$1 reloaded\e[39m"

		basename=$(basename $VARDIR/$1)
		echo $basename=${!basename}
	else
		echo -e "\e[31m$1 cannot found\e[39m"
	fi
}

function show-variable() {
	if [ -f $VARDIR/$1 ];
	then
		source $VARDIR/$1
		basename=$(basename $VARDIR/$1)
		tmp_variable=${!basename}
		if [ ${#tmp_variable} == 0 ];
		then
			echo -e "\e[39m$basename=${!basename}\e[39m"
		else
			echo -e "\e[32m$basename=${!basename}\e[39m"
		fi
	else
		echo -e "\e[31m$1 cannot found\e[39m"
	fi
}
complete -F _list_variables show-variable
complete -F _list_variables reload-variable
