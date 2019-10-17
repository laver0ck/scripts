# Modules for ansible

## get_oracle_homes.py
Get all ORACLE_HOME`s on target host from profiles in oracle home directory

Usage:
```yaml
- name: get oracle profiles
  get_oracle_homes:
  register: homes

- name: get oracle profiles from path
  get_oracle_homes:
    home_path: '/opt/oracle'
```