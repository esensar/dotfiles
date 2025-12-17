# Based on https://blog.esc.sh/how-i-organize-git-repos-locally/
# And slightly modified, as a replacement for pj omf plugin

function pj -d "Search projects directory and navigate to selected project"
	set -f projects_path "$HOME/src"
	if count $argv >/dev/null
		set -f repo_path (find "$projects_path" -mindepth 3 -maxdepth 6 -type d -execdir test -d {}/.git ';' -print -prune | awk -F "$projects_path" '{print $2}' | fzf --query="$argv" -1 | head -n 1)
	else
		set -f repo_path (find "$projects_path" -mindepth 3 -maxdepth 6 -type d -execdir test -d {}/.git ';' -print -prune | awk -F "$projects_path" '{print $2}' | fzf)
	end

	if test -n "$repo_path"
		cd "$projects_path$repo_path"; or echo "Failed to navigate to $projects_path$repo_path"
	else
		echo "No repository selected."
	end
end
