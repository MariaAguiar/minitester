#!/usr/bin/expect -f

[ -e out_bash ] && rm -rf out_bash
[ -e out_minishell ] && rm -rf out_minishell
[ -e test_list ] && rm -rf test_list

bash ./gen_tests.sh
bash ./run_bash.sh
expect minishell.exp | grep -ve '[$]' > res.txt
bash ./veridict.sh
exit;
