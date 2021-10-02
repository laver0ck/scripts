#!/bin/bash
# backup Chromium bookmarks to repo
# windows with git bash version
BOOKS_LOC='/c/Users/user/AppData/Local/Chromium/User Data/Default/Bookmarks'
REPO='/c/Users/user/bookmarks'

file_stat=$(stat -c %Y "$BOOKS_LOC")
repo_stat=$(cat "$REPO/statfile")

if [[ $file_stat != $repo_stat ]]; then
  cd "$REPO"
  cp "$BOOKS_LOC" .
  echo "$file_stat" > "$REPO/statfile"
  comm_date=$(date)
  git add .
  git commit -am "update: $comm_date"
  git push origin master
  echo "bookmarks updated: $comm_date"
else
  echo "bookmarks hadn't changed"
fi
