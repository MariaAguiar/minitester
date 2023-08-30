#!/usr/bin/env bash

[ -e out_bash ] && rm -rf out_bash
[ -e out_minishell ] && rm -rf out_minishell
[ -e test_list ] && rm -rf test_list
mini="res"
prefix1="[?2004h"
prefix2="[?2004l"
i=0
n=1

clean_test()
{
    while read -r line; do
		line=$(echo "$line" | tr -cd '[:print:]')
		while [[ "${line}" = "$prefix2"* || "${line}" = "$prefix1"* ]]; do
			if [[ "${line}" = "$prefix2"* ]]; then
				line=${line#"$prefix2"}
			elif [[ "${line}" = "$prefix1"* ]]; then
				line=${line#"$prefix1"}
			fi
		done
		beg="${line:0:1}"
		if [[ "${#line}" > 0 ]]; then
			if [[ "${line}" = *"spawn"* ]]; then
				continue
			elif [[ $beg == "$" ]]; then
				touch out_minishell/${mini}
			else
				echo "${line}" >> out_minishell/${mini} 2>&1;
			fi
		fi
    done < $mini
}

do_tests()
{
	test="test_list/test"
	chmod +rwx "${test}${n}";
	while [ -e "${test}${n}" ]; do
		test="test_list/test"
		local bash="out_bash/res"
		bash+="$n"
		mini="res"
		mini+="$n"
		[ -e "${test}${n}" ] && ( bash ./"${test}${n}" > $bash 2>&1 );
		[ -e "${test}${n}" ] && expect minishell.exp "${test}${n}" > $mini 2>&1;
		clean_test
		i=$((i+1))
		n=$((n+1))
		[ -e "${mini}" ] && rm "${mini}"
		[ -e "${test}${n}" ] && chmod +rwx "${test}${n}";
	done
}

bash ./gen_tests.sh
mkdir out_minishell
mkdir out_bash
chmod +rwx out_bash;
chmod +rwx out_minishell;
do_tests;
bash ./veridict.sh
exit;
