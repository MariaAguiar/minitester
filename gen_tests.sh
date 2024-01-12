#!/usr/bin/env bash

flag=0;
for i in "$@"; do
	if [[ $i == "bonus" ]]; then
		flag=1;
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
		echo $line >> $test 2>&1;
		if [[ $flag == 0 ]]; then
			sed -i 's/&&/\n/g' $test
			sed -i 's/||/\n/g' $test
			sed -i 's/;/\n/g' $test
		fi
		mv $test $directory
		n=$((n+1))

	fi
    done < $filename
}

# Creating the tests
filename='tests.txt'
directory='test_list'
mkdir $directory
chmod +rwx $directory;
create_tests;
exit;
