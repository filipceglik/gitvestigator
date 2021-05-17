#!/bin/bash
case_sensitive=true
script_path=$(pwd)
while getopts ":s:o:r:i" opt; do
		case ${opt} in
			s ) 
				strs+=${OPTARG}
				;;
			o ) 
				out=${OPTARG}
				;;
			r ) 
				path=${OPTARG}
				;;
			i ) 
				case_sensitive=false
				;;
		esac
done
shift $((OPTIND -1))

git config --global core.pager cat

cd ${path}
for val in "${strs[@]}"; do
	if [ ! $case_sensitive ]; then
		git log --all --pickaxe-regex -p --color-words -G$val -i 2>&1 | tee $script_path/$out-$val
	else
		git log --all --pickaxe-regex -p --color-words -G$val 2>&1 | tee $script_path/$out-$val
	fi
done
