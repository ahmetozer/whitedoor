if [ ${#1} -gt "0" ]
then
	case "$1" in
	-h|--help)
		command-help
	;;
	*)
		type -t $1 > /dev/null && $1 ${@:2} || echo -e "\e[31mError argument is not found\e[32m"
	;;
	esac
else
	type -t main > /dev/null && main ${@:2} || echo -e "\e[31mMain function is not found\e[32m"
fi
