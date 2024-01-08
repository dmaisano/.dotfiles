# Delete all local branches except default or current working branch
function gbr
  set current_branch (git symbolic-ref --short HEAD)
  set default_branch (git symbolic-ref refs/remotes/origin/HEAD | sed 's@^refs/remotes/origin/@@')
  git branch | grep -Ev  "$default_branch|$current_branch" | xargs -r git branch -D
end
