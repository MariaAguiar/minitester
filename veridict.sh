#!/usr/bin/env bash

# ANSI color escape sequences
RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
UNDERLINE='\033[4m'
RESET='\033[0m'

move_tests()
{
    i=0
    local prefix1="[?2004h$"
    local prefix2="[?2004l"
    local suffix="res"
    res="${directory}/res"
    while read -r line; do
    	if [[ "${#line}" > 0 ]]; then
		if [[ "${line}" = "$prefix1"* ]]; then
		    i=$((i+1))
		    res="${directory}/res"
		    res+="$i"
		    touch $res
		elif [[ "${line}" = "$prefix2"* ]]; then
		    i=$((i+1))
		    res="${directory}/res"
		    res+="$i"
		    touch $res
		    tline=$(printf "%s" "${line}" | sed 's/\x1b\[?2004l//g')
		    tline2=${tline:1}
		   echo "${tline2:0:-1}" >> $res 2>&1;
		elif [[ "${res: -3}" != "$suffix" ]]; then
		    echo "${line:0:-1}" >> $res 2>&1;
		fi
        fi
    done < $filename
}

veridict()
{
    n=1
    while read line; do
    	if [[ "${#line}" > 0 ]]; then
		local res="res"
		res+="$n"
		local dif_bash
		local dif_shell
		dif_bash=$(grep "command not found" out_bash/${res} | wc -l)
		dif_shell=$(grep "command not found" ${directory}/${res} | wc -l)
		if diff -q out_bash/${res} ${directory}/${res} > /dev/null 2>&1; then
		    echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
		    echo ""
		elif [[ ${dif_bash} > 0 && ${dif_bash}=${dif_shell} ]]; then
		    echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
		    echo ""
		else
		    echo -ne "Test ${n}: ${RED} [KO]${RESET}"
		    echo ""
		fi
		n=$((n+1))
        fi
    done < tests.txt
}

# Doing the tests from minishell
# And getting the results!
filename='res.txt'
directory='out_minishell'
mkdir $directory
chmod +rwx $directory;
chmod +rwx out_bash;
move_tests;
veridict;
rm $filename
exit;
