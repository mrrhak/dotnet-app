#!/bin/bash
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD
git filter-branch --env-filter '
if [ "$GIT_COMMITTER_EMAIL" = "mrrhak@MrrHak-MacBook-Pro.local" ]
then
    export GIT_COMMITTER_NAME="Mrr Hak"
    export GIT_COMMITTER_EMAIL="longkimhak.kh@gmail.com"
fi
if [ "$GIT_AUTHOR_EMAIL" = "mrrhak@MrrHak-MacBook-Pro.local" ]
then
    export GIT_AUTHOR_NAME="Mrr Hak"
    export GIT_AUTHOR_EMAIL="longkimhak.kh@gmail.com"
fi
' -- --all
