# .dotfiles

## Quick setup
Clone in `~/.dotfiles` and run make:
```
make bootstrap
```

## Contents
1. *installed_packages* directory used in Linux and Mac installations to create groups of installed packages, which can easily be cloned using **clone-installation** script. List is generated using **migrate-installation** script and it can be compared with any other using **compare-installation**.
2. *themes* directory used mostly for **Arch Linux** installations to generate custom themes from small files containing color definitions
3. *symlinks* directory containing many configuration files which are symlinked during installation process in their correct places to be used later
    - **Git** related files - global *gitconfig* and *gitignore*
    - **Shell** config files - bash/zsh/fish for linux/mac
    - **Vim/Nvim** config files
    - **Arch** config files - many configuration files controlling most of the setup
    - **config** directory, containing custom configurations for many apps (most of Linux apps and some of Mac OS apps)
    - **bin** director containing many useful scripts, many of them requiring **Arch Linux** and its setup

## Installation manual
### Linux (Arch)
1. Install Arch based distribution of choice (Arch - https://wiki.archlinux.org/index.php/Installation_guide)
2. Install git
3. Clone this repo into $HOME
4. Run `make bootstrap`
5. (Optional) Run clone-installation and select installation to clone

### Linux (Other)
1. Install Linux distribution of choice
2. Install git
3. Clone this repo into $HOME
4. Run make `make bootstrap`
5. Everything should be fine. Many custom scripts may not work, since they rely on either **pacman** or some of the basic packages installed using **clone-installation** script, which is also using **pacman**

### Mac OS
1. Clone this repo into $HOME
2. Run make `make bootstrap`
3. If you need more homebrew packages, check *installed_packages* directory and choose your list. Install it by moving into specific packages set directory and running `brew bundle` (or `clone-installation` if you have sourced new ~/.profile)

### Windows
1. Clone this repo into user home
2. Run `make bootstrap` or run `windows/install_windows.bat` directly with double click or through cmd
3. This will only link vim and git configurations

## Post installation steps

After installation optionally check out `installed_packages` directory for packages to install using `clone-installation`.

This repository also provides a simple way to generate main personal ssh key to be used with GitHub:
```
make create_personal_ssh_github_key
```

It is recommended to also clone `vimwiki` and use it:
```
make clone_personal_viwiki
```
