function cclone -d "Clone repository into a canonical directory, searchable with pj"
	set -f projects_path "$HOME/src"
	if count $argv >/dev/null
		set -f url (string split -f 2 "@" "$argv[1]")
		set -f forge (string split -f 1 ":" "$url")
		set -f full_repo (string split -f 2 ":" "$url")
		set -f repo_path (string split -f 1 ".git" "$full_repo")
		return (git clone "$argv[1]" "$projects_path/$forge/$repo_path")
	else
    echo (set_color red)'error:' (set_color normal)'missing repository url (or multiple arguments passed)'
    echo (set_color cyan)'usage:' (set_color normal)'cclone <single repository ssh url>'
    return 23  # EINVAL
	end
end
