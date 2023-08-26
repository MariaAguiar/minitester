#!/usr/bin/env bash

# Fill in files for comparison
create_tests()
{
    begin_line="#! /usr/bin/env bash"
    n=1
    i=0
    while read line; do
	if [[ ${#line}>0 ]]; then
		i=$((i+1))
		local test='test'
		test+="$n"
		test+=".sh"
		echo "$begin_line" >> $test 2>&1;
		echo $line >> $test 2>&1;
		echo "" >> $test 2>&1;
		mv $test $directory
		n=$((n+1))
	fi
    done < $filename
}

# Doing the tests and comparing
filename='tests.txt'
directory='test_list'
mkdir $directory
chmod +rwx $directory;
create_tests;
exit;
