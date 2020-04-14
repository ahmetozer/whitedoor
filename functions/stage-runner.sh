function stage-runner() {
	for i in {4..35}
	do
   echo "Now you are running stage 5.$i"
	 Chapter_Script=$(echo $ProjectDIR/lfs-chapter-scripts/chapter-5/5.${i}---*.sh)
	 local basename=$(basename $Chapter_Script)
	 if [ -f "$Chapter_Script" ]; then
		 if is-ok-variable state-5-$i
		 then
			 echo "$Chapter_Script is already runned"
		 else
			 echo "$Chapter_Script is running"
			 #bash -e $Chapter_Script 2>&1 | tee -a $ProjectDIR/log/${basename}.log
			 if [ $? -eq 0 ]
			then
				echo "Task ${basename} Successfully completed."
				variable-generate state-5-$i ok
			else
				echo "ERR at stage $i on ${basename}. You can access log on $ProjectDIR/log/${basename}.log"
			fi
		 fi
	 else
		 echo "ERR $Chapter_Script does not exist"
	 fi
	 mkdir -p $ProjectDIR/log/


	done
}
