import sys
import os

''' TODO:
    - get log from jenkins job with requests(auth)
    - wildcards (glob.glob)
    - get logs from range of jenkins jobs (e.g. 20-50) and parse them
'''

usage = '''
Usage: parser.py file1 [file2...file_n]
No wildcards supported yet
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
        task_printed = False
        for i in file.readlines():
            if i.startswith("TASK ["):
                task_name = i
                task_printed = False
            elif i.startswith('fatal:') or i.startswith('failed:'):
                if task_printed is False:
                    print(task_name, end='')
                    print(i)
                    task_printed = True
                else:
                    print(i)
