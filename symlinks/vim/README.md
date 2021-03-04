## My vim configuration

Currently configuration is shared between Vim and NeoVim, although I use NeoVim. Migration will happen when NeoVim 0.5.0 is released and `init.lua` is supported.

Configuration is separated into directories:
 - `plugin` for logical collection of functionalities into a simple plugin
 - `colors` my colorscheme
 - `compiler` for compiler plugins
 - `ftdetect` for autocommands for detecting file types
 - `undodir` is just a placeholder for configured undo directory
 - `spell` for spelling dictionary
 - `after` with same directory structure for loading after plugins - allows easy overrides, most `ftplugins` are here

Besides this, directory contains other files:
 - `plugins.vim` all used plugins
 - `vimrc` global basic configuration
