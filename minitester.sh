#!/usr/bin/env bash

[ -e out_bash ] && rm -rf out_bash
[ -e out_minishell ] && rm -rf out_minishell
[ -e test_list ] && rm -rf test_list

mini="res"
i=0
n=1

flag=0;
for i in "$@"; do
	if [[ $i == "exact" ]]; then
		flag=1;
	fi
done

prompt=$(bash ./gen_prompt.sh);
clean_test()
{
    dir=$1
    mini=$2
    touch "${dir}/${mini}"
    while read -r line; do
		if [[ "${line}" = "${prompt}"* ]]; then
			continue ;
		else
			echo "${line}" >> "${dir}/${mini}";
		fi
    done < $mini
}

do_tests()
{
	test="test_list/test"
	chmod +rwx "${test}${n}";
	while [ -e "${test}${n}" ]; do
		test="test_list/test"
		local bash="res"
		bash+="$n"
		mini="res"
		mini+="$n"
		if [[ $flag == 0 ]]; then
			bash < "${test}${n}" > $bash 2>/dev/null
		else
			bash < "${test}${n}" > $bash 2>&1
		fi
		orig="bash: line \([0-9]*\)"
		dest="minishell"
		sed "s|${orig}|${dest}|g" "$bash" > new_bash
		mv new_bash "$bash"
		clean_test "out_bash" "$bash"
		if [[ $flag == 0 ]]; then
			../minishell < "${test}${n}" > $mini 2>/dev/null
		else
			../minishell < "${test}${n}" > $mini 2>&1
		fi
		clean_test "out_minishell" "$mini"
		i=$((i+1))
		n=$((n+1))
		[ -e "${mini}" ] && rm "${mini}"
		[ -e "${test}${n}" ] && chmod +rwx "${test}${n}";
	done
}

bash ./gen_tests.sh "$@"
mkdir out_minishell
mkdir out_bash
chmod +rw out_bash;
chmod +rw out_minishell;
do_tests;
bash ./veridict.sh "$@"
exit;
