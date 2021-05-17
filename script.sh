#!/bin/bash

script_path=$(pwd)
while getopts ":s:o:r:" opt; do
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
		esac
done
shift $((OPTIND -1))

git config --global core.pager cat

echo $path
cd ${path}
for val in "${strs[@]}"; do
	git log --all --pickaxe-regex -p --color-words -G$val -i 2>&1 | tee $script_path/$out-$val
done
