#!/bin/bash
strs=""
out=""
path=""
case_sensitive=true
while getopts :s:o:i:r: opt; do
		case "${opt}" in
			s ) strs+=("$OPTARG");;
			o ) out=${OPTARG};;
			i ) case_sensitive=false;;
			r ) path=${OPTARG};;
		esac
	done
	shift $((OPTIND -1))

git config --global core.pager cat
echo "$path"
cd ${path}
for val in "${strs[@]}"; do
	echo $str
	if [ ! $case_sensitive ]; then
		git log --all --pickaxe-regex -p --color-words -G'${str}' -i > ${out}-${str}
	else
		git log --all --pickaxe-regex -p --color-words -G'${str}' > ${out}-${str}
	fi
done
