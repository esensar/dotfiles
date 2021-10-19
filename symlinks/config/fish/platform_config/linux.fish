if which termux-info  &> /dev/null
	alias pbcopy 'termux-clipboard-set'
	alias pbpaste 'termux-clipboard-get'
else if set -q WAYLAND_DISPLAY; and type -q wl-paste; and type -q wl-copy
	alias pbcopy 'wl-copy'
	alias pbpaste 'wl-paste'
else
	alias pbcopy 'xsel -i'
	alias pbpaste 'xsel -o'
end
