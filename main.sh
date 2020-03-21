#!/bin/bash

#	Preparing Paths
OLDPATH=$PATH
ProjectDIR=$(pwd)


# Term Colors
#	\e[39m Default
#	\e[31m RED
#	\e[32m GREEN

#Entering the project shell
#HOME=$ProjectDIR PATH=$PATH:$ProjectDIR/functions bash  --rcfile $ProjectDIR/functions/bashrc.sh --noprofile
HOME=$ProjectDIR  bash  --rcfile $ProjectDIR/config/bashrc.sh --noprofile
