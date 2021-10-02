'''
Function uses windows api to prevent computer from going to sleep.
Useful if you don't have rights to change windows power settings.
'''

import asyncio
import ctypes

loop = asyncio.get_event_loop()
try:
    ctypes.windll.kernel32.SetThreadExecutionState(0x80000002)
    print('Running...')
    loop.run_forever()

except KeyboardInterrupt:
    print("Exiting...")

finally:
    ctypes.windll.kernel32.SetThreadExecutionState(0x80000000)
    loop.close()
