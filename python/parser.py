import sys

''' TODO:
    1. get log from jenkins job with requests(auth)
    2. multiple files as arguments
    3. wildcards (glob.glob)
    4. get logs from range of jenkins jobs (e.g. 20-50) and parse them
'''

usage = '''
Usage: parser.py file_to_parse
Only one file at a time, no wildcards
'''

if len(sys.argv) == 1 or len(sys.argv) > 2:
    print('\nWrong arguments!')
    print(usage)
    exit(1)
elif sys.argv[1] and sys.argv[1] in ['-h', '--help']:
    print(usage)
    exit(1)

with open(sys.argv[1]) as file:
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
