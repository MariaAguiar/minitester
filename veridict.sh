#!/usr/bin/env bash

# ANSI color escape sequences
RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
UNDERLINE='\033[4m'
RESET='\033[0m'

#Gathering needed variables
filename='res.txt'
directory='out_minishell'
prefix1="[?2004h"
prefix2="[?2004l"

# Comparing results
veridict()
{
    n=1
    while read line; do
    	if [[ "${#line}" > 0 ]]; then
			local res="res"
			res+="$n"
			local dif_patt_bash
			local dif_patt_shell
			dif_patt_bash=$(grep "unexpected" out_bash/${res} | wc -l)
			dif_patt_shell=$(grep "unexpected" ${directory}/${res} | wc -l)
			local dif_args_bash
			local dif_args_shell
			dif_args_bash=$(grep "too many arguments" out_bash/${res} | wc -l)
			dif_args_shell=$(grep "too many arguments" ${directory}/${res} | wc -l)
			local dif_file_bash
			local dif_file_shell
			dif_file_bash=$(grep "No such file or directory" out_bash/${res} | wc -l)
			dif_file_shell=$(grep "No such file or directory" ${directory}/${res} | wc -l)
			local dif_found_bash
			local dif_found_shell
			dif_found_bash=$(grep "command not found" out_bash/${res} | wc -l)
			dif_found_shell=$(grep "command not found" ${directory}/${res} | wc -l)
			if diff -q out_bash/${res} ${directory}/${res} > /dev/null 2>&1; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ ${dif_file_bash} > 0 && ${dif_file_bash}=${dif_file_shell} ]]; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ ${dif_found_bash} > 0 && ${dif_found_bash}=${dif_found_shell} ]]; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ ${dif_args_bash} > 0 && ${dif_args_bash}=${dif_args_shell} ]]; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ ${dif_patt_bash} > 0 && ${dif_patt_bash}=${dif_patt_shell} ]]; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ "${line}" = *";"*  ]]; then
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

# Getting the results!
chmod +rwx $directory;
chmod +rwx out_bash;
veridict;
exit;
