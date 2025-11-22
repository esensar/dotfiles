# From: https://github.com/jhillyerd/plugin-git/blob/master/functions/__git.current_branch.fish
function __git.current_branch -d "Output git's current branch name"
  begin
    git symbolic-ref HEAD; or \
    git rev-parse --short HEAD; or return
  end 2>/dev/null | sed -e 's|^refs/heads/||'
end
