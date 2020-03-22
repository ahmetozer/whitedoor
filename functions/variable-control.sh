
function reload-variables() {
	source $VARDIR/*
}

function show-variables() {
FILES=$VARDIR/*
reload-variables
for f in $FILES
do
	basename=$(basename $f)
	local tmp_variable=${!basename}
	if [ ${#tmp_variable} == 0 ];
	then
		printf "\e[39m$basename=${!basename}\e[39m"
	else
		printf "\e[32m$basename=${!basename}\e[39m"
	fi
done
}



function show-variable() {
	if [ -f $VARDIR/$1 ];
	then
		source $VARDIR/$1
		basename=$(basename $VARDIR/$1)
		local tmp_variable=${!basename}
		if [ ${#tmp_variable} == 0 ];
		then
			printf  "\e[39m$basename=${!basename}\e[39m"
		else
			printf  "\e[32m$basename=${!basename}\e[39m"
		fi
	else
		printf  "\e[31m$1 cannot found\e[39m"
	fi
}

function reload-variable() {
	if [ -f $VARDIR/$1 ];
	then
		source $VARDIR/$1
		basename=$(basename $VARDIR/$1)
		local tmp_variable=${!basename}
		export $basename=$tmp_variable
		printf "\e[32m$1 reloaded\e[39m "
		show-variable $1
	else
		printf "\e[31m$1 cannot found\e[39m"
	fi
}

function delete-variable() {
	if [ -f $VARDIR/$1 ];
	then
		rm $VARDIR/$1
		unset $1
	else
		printf "\e[31m$1 is already deleted\e[39m"
	fi
}

function unset-variable() {
	if [ -f $VARDIR/$1 ];
	then
		printf "$1=" > $VARDIR/$1
		source $VARDIR/$1
	else
		printf "\e[31m$1 is already deleted\e[39m"
	fi
}
function is-setted-variable() {
	if [ -f $VARDIR/$1 ];
	then
		source $VARDIR/$1
		basename=$(basename $VARDIR/$1)
		local tmp_variable=${!basename}
		if [ ${#tmp_variable} == 0 ];
		then
			#printf "\e[39m$basename=${!basename}\e[39m"
			printf false
		else
			#printf "\e[32m$basename=${!basename}\e[39m"
			printf true
		fi
	else
		printf "\e[31m$1 cannot found\e[39m"
	fi
}

function re-declare-variable() {
	local question
 read -p "$(show-variable $1) is already declared. Do you want to redeclare your variable ? » " -e  question
 if [ "$question" == 'yes' ];
 then
	 unset-variable $1
	 unset $1
 fi
}


complete -F _list_variables show-variable
complete -F _list_variables reload-variable
complete -F _list_variables is-setted-variable
complete -F _list_variables re-declare-variable
complete -F _list_variables delete-variable
complete -F _list_variables unset-variable
