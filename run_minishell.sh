#!/usr/bin/env bash

# ANSI color escape sequences
RED='\033[1;31m'
GREEN='\033[1;32m'
RESET='\033[0m'

do_tests()
{
    n=1
    i=0
    while read line; do
        i=$((i+1))
        local test='test_list/test'
        test+="$n"
        test+=".sh"
        local res='res'
        res+="$n"
        chmod +rwx $test;
        ./${test} >> $res 2>&1;
        mv $res $directory
        n=$((n+1))
    done < $filename
}

veridict()
{
    n=1
    i=0
    while read line; do
        i=$((i+1))
        local res='res'
        res+="$n"
        if diff -q out_bash/${res} $directory/${res} > /dev/null 2>&1; then
            echo -ne "Test ${i}: ${GREEN} [OK]${RESET}"
            echo ""
        else
            echo -ne "Test ${i}: ${RED} [KO]${RESET}"
            echo ""
        fi
        n=$((n+1))
    done < $filename
}

# Doing the tests from minishell
# And getting the results!
filename='tests.txt'
directory='out_minishell'
mkdir $directory
chmod +rwx $directory;
chmod +rwx out_bash;
do_tests;
veridict;
exit;