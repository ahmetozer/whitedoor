fixs="sh-not-point-to-bash test-function"

function fix-this (){
(
	empty-function(){
		true
	}
	sh-not-point-to-bash(){
		command-help(){
			echo -e 'Fix  \n\t "ERROR: /bin/sh does not point to bash" error'
		}
		main(){
			ln -sf bash /bin/sh
		}
		$1 ${@:2}
	}

	test-function(){
		command-help(){
			echo -e 'this is a example fix function'
		}
		main(){
			echo -e "Problem fixed"
		}
		$1 ${@:2}
	}

	if  type -t $1 > /dev/null
	then
		if [ ${#2} -gt 1 ]
		then
				$1 ${@:2}
		else
			$1 command-help
			local question
			read -p "Do you want to apply fix ? » " -e -i yes question
		  if [ "$question" == 'yes' ];
		  then
				echo -e "\e[32mOkay fix is apply...\e[39m"
		 		$1 main
			else
				echo -e "\e[31mfix is not applied.\e[39m"
		  fi
		fi
	else
		echo -e "\e[31mFunction is not avaible\e[39m"
	fi
)
}
#
#
# while read line
#do
#		printf "\t $line\n"
#done < <(	grep -E '^[[:space:]]*([[:alnum:]_]+[[:space:]]*\(\)|function[[:space:]]+[[:alnum:]_]+)' functions/$1 | cut -d ":" -f 2 | cut -d" " -f 2 | cut -d"(" -f 1 )
complete -W "$fixs" fix-this
