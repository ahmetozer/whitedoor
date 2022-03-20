function final-preparations() {
	if is-mounted-lfs
	then
		mkdir -v $LFS/tools

		source $VARDIR/LFSTOOLS_IN_ROOT_DIRECTORY_CREATED_BY_SCRIPT
		if [ "$LFSTOOLS_IN_ROOT_DIRECTORY_CREATED_BY_SCRIPT" == "yes" ]
		then
			ln -sv $LFS/tools /
			groupadd lfs
			useradd -s /bin/bash -g lfs -m -k /dev/null lfs

			source $VARDIR/LFS_USER_PASSWORD
			if [ ! "${#LFS_USER_PASSWORD}" -eq 32 ]
			then
				LFS_USER_PASSWORD=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`
				printf "LFS_USER_PASSWORD=$LFS_USER_PASSWORD" > $VARDIR/LFS_USER_PASSWORD
			fi
			echo -e "$LFS_USER_PASSWORD\n$LFS_USER_PASSWORD" | passwd  lfs

			chown -v lfs $LFS/tools
			chown -v lfs $LFS/sources
			chown -v lfs /tools
		else
			if [ -d /tools ];
			then
				echo -e "\e[31mThis function requires /tools directory but this director used by you.\nPlease rename or move /toos directory for final-preparations function\e[39m"
			else
				printf 'LFSTOOLS_IN_ROOT_DIRECTORY_CREATED_BY_SCRIPT=yes' > $VARDIR/LFSTOOLS_IN_ROOT_DIRECTORY_CREATED_BY_SCRIPT
			fi
		fi
		local LFS_USER_HOME=`eval echo ~lfs`
		cat > $LFS_USER_HOME/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\e[95m\u \[\033[96m\]WhiteDoor\[\033[m\] X \[\033[32m\]$(uname -m):\[\033[33;1m\]\w\[\033[m\]\$ ' /bin/bash
EOF

		cat > $LFS_USER_HOME/.bashrc << "EOF"
set +h
umask 022
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/tools/bin:/bin:/usr/bin
export LFS LC_ALL LFS_TGT PATH
PS1='\e[95m\u \[\033[96m\]WhiteDoor\[\033[m\] X \[\033[32m\]$(uname -m):\[\033[33;1m\]\w\[\033[m\]\$ '
export MAKEFLAGS="-j $(nproc)"
EOF
		printf "LFS=$LFS" >> $LFS_USER_HOME/.bashrc
		chown -v lfs $LFS_USER_HOME/.*

	else
		echo -e "\e[31mPlease mount LFS directory to run tools function\e[39m"
	fi

}

required_variables=(LFSTOOLS_IN_ROOT_DIRECTORY_CREATED_BY_SCRIPT LFS_USER_PASSWORD)
