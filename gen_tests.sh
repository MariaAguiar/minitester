#!/usr/bin/env bash

filename="tests.txt";
for i in "$@"; do
	if [[ $i == "bonus" ]]; then
		filename="tests_bonus.txt";
	fi
done

create_tests()
{
    n=1
    i=0
    while read line; do
	if [[ ${#line} -gt 0 ]]; then
		i=$((i+1))
		local test='test'
		test+="$n"
		line2=$line;
		echo $line >> $test;
		mv $test $directory
		n=$((n+1))

	fi
    done < $filename
}

# Creating the tests
directory='test_list'
mkdir $directory
chmod +rwx $directory;
create_tests;
exit;
