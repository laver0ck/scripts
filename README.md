## Ansible module for shutting down oracle DB

Takes list of sids in bash args format ```"sid1 sid2 etc..."```

Usage:
```
- name: shutdown oracle DBs
  shutdown:
    sid_list: "{{ sidsLst | join(' ') }}"
```