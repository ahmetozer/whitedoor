
function list-function() {
	echo " Functions for $1"
	while read line
  do
      printf "\t $line\n"
  done < <(	grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' $ProjectDIR/functions/$1 | cut -d ":" -f 2 | cut -d" " -f 2 | cut -d"(" -f 1)
}

function list-all-functions() {
	grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' $ProjectDIR/functions/* | cut -d ":" -f 2 | cut -d" " -f 2 | cut -d"(" -f 1
}


function help() (
	command-help() (
		printf "Shows help for envoriment end functions"
	)
	if [ ${#1} -gt "0" ]
	then
		case "$1" in
		-h|--help)
			command-help
		;;
		*)
			type -t $1 > /dev/null && $1 ${@:2} -h || echo -e "\e[31mError argument is not found\e[32m"
		;;
		esac
	else
		type -t main > /dev/null && main ${@:2} || echo -e "\e[31mMain function is not found\e[32m"
	fi
)
complete -F _list_functions help
complete -F _list_functions list-function
