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
			if diff -q out_bash/${res} ${directory}/${res} > /dev/null 2>&1; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
			elif [[ "${line}" = *";"* ]]; then
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
