set -l needs_fetch 1
function __fish-git-pr-review-fetch
    git fetch &
    set -l needs_fetch 0
    return 1
end

function __fish-git-pr-review-in-git-repo
    git rev-parse --is-inside-work-tree 2>/dev/null
end

complete -c git-pr-review -f
complete -c git-pr-review -n '__fish-git-pr-review-in-git-repo; and __fish-git-pr-review-fetch' -w 'git branch'
