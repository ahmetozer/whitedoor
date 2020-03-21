
list-function() {
	while read line
  do
      echo -e "\t $line"
  done < <(	grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' functions/$1 | cut -d ":" -f 2 | cut -d" " -f 2 | cut -d"(" -f 1)
}

function list-all-functions() {
	grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' functions/* | cut -d ":" -f 2 | cut -d" " -f 2 | cut -d"(" -f 1
}

command-help() {
	true
}
function help() {
	if [ -z "$1" ]
	then
		echo -e "WhiteDoor Project Builder Enviroment\nHere is avaible comamnds\n"
		FILES=$ProjectDIR/functions/*
		for f in $FILES
		do
			basename=$(basename $f)
			echo $basename
			list-function $basename
			echo
		done
		echo
	else
		unset -f command-help
		source $1
		type -t command-help > /dev/null && command-help || echo -e "\e[31mHelp is not avaible\e[39m"
		unset -f command-help
	fi
}
complete -F _list_functions help
