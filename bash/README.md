# Bash scripts for different tasks

## shutdown.sh
Shut down all oracle DBs on the host

Takes list of sids and stops all corresponding DBs with 15 minutes timeout per DB. Checks memory afterwards.  
If fails, performs `shutdown abort`.

Usage:
```shell
$ whoami
oracle
$ shutdown.sh [sid1 sid2 ... sidN]
```

## startup.sh
Starts all oracle DBs on the host

Takes list of SIDs, checks corresponding oracle profiles and starts DBs with 5 minutes timeout.

Usage:
```shell
$ whoami
oracle
$ startup.sh [sid1 sid2 ... sidN]
```

## cpu_usage.sh
Get top-10 CPU consumers  
Default watch time is 1 hour, to change rewrite SECS var inside script.

## pass_gen.sh
CLI password generator.  
Default length = 8 chars.

## inet_check.sh
Quick check if internet is OK.  
Pings google.com and returns result.

## backup_file.sh
Backup file to /var/{filename}  
