#!/usr/bin/env bash

prompt="tmp";
echo exit > get_prompt
../minishell < get_prompt > $prompt;
rm get_prompt
while read line; do
    line2="${line%exit}"
    echo "${line2}"
done < $prompt
rm $prompt
exit;
