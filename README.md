# minitester
Tester for the 42 Common Core 'minishell' project | Made to help during the development stage | On going

Prerequisites:
- Have 'expect' installed in your linux distribution. If not, run:
sudo apt install expect
- Your shell executable must have functional prompt capturing and processing capabilities
- Your shell must be named 'minishell' and have a readline prompt containing the sequence '$ ' (dollar sign + space)


Instructions:
- Place the 'minitester' folder next to your minishell executable
- Enter the 'minitester' folder and run:
bash ./minitester.sh


Evaluating the results:
- Check individual tests by comparing the output of the files within the 'out_bash' and 'out_minishell' folders
For this, look for matching filenames in both folders in the format 'res + test number'
- Check the content of the performed test in the 'test_list' folder (test + test number + .sh)
- At the time of writing, this program has not been tested against final minishell projects.
Please, see this program as an auxiliar program and not as a means of final testing.


Further usage:
- You can add more tests by adding new lines to the "tests.txt" file within the 'minitester' folder.
  Please add them before the last line of the file (containing the 'exit\' sequence)
- New tests function properly in one-line format. At the time of writing multiline test format has not been addressed


Final considerations:
- In cases where the results involve stderr messages, several validations were added checking for equivalent statements in both files.
Since these kinds of statements can be hard to match in between shell terminals and linux distributions - plus this program uses 'diff' statements, these validations were added.
These can change the results of some of the tests in cases where more the a failed command is tested.
Such extra validations can be removed by deleting the statements and conditions pertaining to the 'dif_*_bash' and 'dif_*_shell' variables in the file 'veridict.sh'.

Thanks!
