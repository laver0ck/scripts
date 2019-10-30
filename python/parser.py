import sys
import os

''' TODO:
    - get log from jenkins job with requests(auth)
    - get logs from range of jenkins jobs (e.g. 20-50) and parse them
'''

usage = '''
Parse ansible logs files, find and print any errors.

    Usage: $ parser.py file1 [file2 ... file_n]
    Wildcards can be used
'''

if len(sys.argv) == 1:
    print('\nWrong arguments!')
    print(usage)
    exit(1)
elif sys.argv[1] and sys.argv[1] in ['-h', '--help']:
    print(usage)
    exit(1)


for file_name in sys.argv[1:]:

    if not file_name.startswith('/'):
        file_name = os.getcwd() + '/' + file_name

    with open(file_name) as file:
        print('===============================')
        print('File: ' + file_name + ':\n')
        task_name = ''
        task_name_printed = False
        for line in file.readlines():
            if line.startswith("TASK ["):
                task_name = line
                task_name_printed = False
            elif line.startswith('fatal:') or line.startswith('failed:'):
                if task_name_printed is False:
                    print(task_name, end='')
                    print(line)
                    task_name_printed = True
                else:
                    print(line)
