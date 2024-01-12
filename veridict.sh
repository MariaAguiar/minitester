#!/usr/bin/env bash

# ANSI color escape sequences
RED='\033[1;31m'
GREEN='\033[1;32m'
WHITE='\033[1;37m'
BLUE='\033[1;34m'
CYAN='\033[1;36m'
UNDERLINE='\033[4m'
RESET='\033[0m'

tests="tests.txt";
for i in "$@"; do
	if [[ $i == "bonus" ]]; then
		tests="tests_bonus.txt";
	fi
done

#Gathering needed variables
filename='res.txt'
directory='out_minishell'

# Reading results
readfile()
{
    read="$1"

    while read line; do
		echo $line
    done < ${read}
}

# Comparing results
veridict()
{
    count=0
    n=1
    while read line; do
    	if [[ "${#line}" > 0 ]]; then
			local res="res"
			res+="$n"
			if diff -q out_bash/${res} ${directory}/${res} 2>&1 > /dev/null; then
				echo -ne "Test ${n}: ${GREEN} [OK]${RESET}"
				echo ""
				count=$((count+1))
			else
				echo -e "Test ${n}: ${RED} [KO]${RESET}"
				echo ""
				if [[ $(cat "test_list/test${n}") != *"env"* && $(cat "test_list/test${n}") != *"export"* && $line != *"*"* ]]; then
					echo "_____________________________"
					echo -e "${GREEN}Test ${n}:${RESET}"
					subcount=0
					while read fileline; do
						subcount=$((subcount+1))
						if [[ $subcount == $n ]]; then
							echo $fileline;
						fi
					done < $tests
					echo -e "${GREEN}Bash: ${RESET}"
					readfile "out_bash/res${n}"
					echo -e "${GREEN}Mini: ${RESET}"
					readfile "out_minishell/res${n}"
					echo "_____________________________"
					echo ""
				fi
			fi
			echo "${count}/${n}"
			n=$((n+1))
        fi
    done < $tests
}

# Getting the results!
veridict;
exit;
