function cclone -d "Clone repository into a canonical directory, searchable with pj"
	set -f projects_path "$HOME/src"

	if count $argv >/dev/null
		if string match -r "^https?://.*" "$argv[1]"
			set url (string split -f 2 "://" "$argv[1]")
			set full_repo_path (string split -f 1 ".git" "$url")
		else if string match -r "^ssh?://.*" "$argv[1]"
			set url (string split -f 2 "@" "$argv[1]")
			set full_repo_path (string split -f 1 ".git" "$url")
		else if string match -r "^git@.*" "$argv[1]"
			set url (string split -f 2 "@" "$argv[1]")
			set forge (string split -f 1 ":" "$url")
			set full_repo (string split -f 2 ":" "$url")
			set repo_path (string split -f 1 ".git" "$full_repo")
			set full_repo_path "$forge/$repo_path"
		else
			echo (set_color red)'error:' (set_color normal)'invalid repository url'
			echo (set_color cyan)'usage:' (set_color normal)'cclone <single repository url>'
			return 23  # EINVAL
		end
		return (git clone "$argv[1]" "$projects_path/$full_repo_path")
	else
		echo (set_color red)'error:' (set_color normal)'missing repository url (or multiple arguments passed)'
		echo (set_color cyan)'usage:' (set_color normal)'cclone <single repository url>'
		return 23  # EINVAL
	end
end
