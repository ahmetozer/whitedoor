_list_variables() {
    local cur
		if [ -d "$VARDIR" ]
		then
    	VARIABLES=$(find $VARDIR/*  -printf "%f\n")
    	cur="${COMP_WORDS[COMP_CWORD]}"
    	COMPREPLY=( $(compgen -W "$VARIABLES" -- ${cur}) )
    	return 0
		else
			echo -e "\e[31m Variable dir is not avaible\e[39m"
		fi
}

_list_functions() {
    local know_hosts cur
    VARIABLES=$(list-all-functions)

    cur="${COMP_WORDS[COMP_CWORD]}"

    COMPREPLY=( $(compgen -W "$VARIABLES" -- ${cur}) )
    return 0
}
