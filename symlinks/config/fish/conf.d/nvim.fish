if which termux-info &> /dev/null
	alias nvim "vim"
	alias vi "vim"
	alias vimdiff "vim -d"
else
	alias vi "nvim"
	alias vim "nvim"
	alias vimdiff "nvim -d"
end
