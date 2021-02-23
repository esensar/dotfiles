## My NeoVim configuration

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
