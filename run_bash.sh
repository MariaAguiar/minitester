#!/usr/bin/env bash

do_tests()
{
    n=1
    i=0
    while read line; do
    	if [[ ${#line}>0 ]]; then
		i=$((i+1))
		local test='test_list/test'
		test+="$n"
		test+=".sh"
		local res="${directory}/res"
		res+="$n"
		chmod +rwx $test;
		./${test} >> $res 2>&1;
		n=$((n+1))
        fi
    done < $filename
}

# Doing the tests from bash
filename='tests.txt'
directory='out_bash'
mkdir $directory
chmod +rwx out_bash;
do_tests;
exit;
