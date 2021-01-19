if which termux-info  &> /dev/null
	alias pbcopy 'termux-clipboard-set'
	alias pbpaste 'termux-clipboard-get'
else
	alias pbcopy 'wl-copy'
	alias pbpaste 'wl-paste'
end
