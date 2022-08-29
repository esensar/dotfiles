UNAME := $(shell sh -c 'uname 2>/dev/null || echo Unknown')
ifeq ($(OS),Windows_NT)
	UNAME := Windows
endif
FILE_SUFFIX := linux
SYMLINK := ln -s
CURRENT_DIR := $(shell pwd)
ifeq ($(DOTFILES_CI), 1)
	DOTFILES_DIR := $(CURRENT_DIR)
	EXTRA_CI_MESSAGE := (CI)
else
	DOTFILES_DIR := $(HOME)/.dotfiles
	EXTRA_CI_MESSAGE :=
endif
SCRIPTS_DIR := $(DOTFILES_DIR)/bin
SYMLINKS_DIR := $(DOTFILES_DIR)/symlinks
BACKUP_DIR := $(HOME)/.local/share/dotfiles_backup
SSH_KEYS_HOME := $(HOME)/.ssh
SSH_CONFIG_FILE := $(SSH_KEYS_HOME)/config
PERSONAL_SSH_KEYS_HOME := $(SSH_KEYS_HOME)/Personal
SCRIPTS_CACHE_DIR := $(HOME)/.local/share/script_cache
SCRIPTS_UTILS_DIR := $(HOME)/.local/opt/script_utils
PROJECTS_ROOT := $(HOME)/Projects
DOCUMENTS_ROOT := $(HOME)/Documents
PICTURES_ROOT := $(HOME)/Pictures
SCREENSHOTS_ROOT := $(PICTURES_ROOT)/Screenshots
WALLPAPERS_ROOT := $(PICTURES_ROOT)/Wallpapers
LOCKSCREENS_ROOT := $(PICTURES_ROOT)/Lockscreens
PERSONAL_PROJECTS_ROOT := $(PROJECTS_ROOT)/Personal
PRACTICE_PROJECTS_ROOT := $(PERSONAL_PROJECTS_ROOT)/Mixed\ Technology/Practice
COPY_TOOL := pbcopy

ifeq ($(UNAME), Linux)
	FILE_SUFFIX := linux
	COPY_TOOL := xclip -selection clipboard
link: link_all_linux
bootstrap: bootstrap_linux
endif
ifeq ($(UNAME), Windows)
	FILE_SUFFIX :=
	COPY_TOOL :=
bootstrap: bootstrap_windows
endif
ifeq ($(UNAME), Darwin)
	FILE_SUFFIX := mac
	COPY_TOOL := pbcopy
link: link_all_mac
bootstrap: bootstrap_mac
endif
ifeq ($(UNAME), Unknown)
check_os: fail_with_unknown_host
endif
ifneq ($(DOTFILES_DIR), $(CURRENT_DIR))
check_os: fail_with_bad_dotfiles_location
endif


# Creates a new symlink in home dir and backs up existing file
# Expects file to be located in symlinks directory
# Takes 2 parameters:
#  - Symlink file name (as defined in symlinks directory)
#  - Name of file in home directory
define link
	@echo "Moving $2 from $(HOME) to $(BACKUP_DIR)"
	@mv $(HOME)/$2 $(BACKUP_DIR)/ || true
	@echo "Creating symlink to $2 in $(HOME)"
	@$(SYMLINK) $(SYMLINKS_DIR)/$1 $(HOME)/$2
endef

# Writes new ssh config entry
# Takes 3 parameters:
#  - Host (ex. github.com)
#  - Host prefix (to prevent conflicts between different keys for same host)
#  - Path to private key
define write_git_ssh_config_entry
	@echo "" >> $(SSH_CONFIG_FILE)
	@echo "Host $2$1" >> $(SSH_CONFIG_FILE)
	@echo "  AddKeysToAgent yes" >> $(SSH_CONFIG_FILE)
	@echo "  UseKeychain yes" >> $(SSH_CONFIG_FILE)
	@echo "  HostName $1" >> $(SSH_CONFIG_FILE)
	@echo "  User git" >> $(SSH_CONFIG_FILE)
	@echo "  IdentityFile $3" >> $(SSH_CONFIG_FILE)
endef

# Creates a new ssh key and saves it to config
# Takes 3 parameters:
#	 - Email
#	 - Host name (ex. codeberg)
#  - Host (ex. codeberg.org)
define create_personal_git_ssh_key
	ssh-keygen -f $(PERSONAL_SSH_KEYS_HOME)/id_ed25519_$2 -t ed25519 -b 4096 -C $1
	@echo "Personal $2 key created!"
	@echo "Copy public key by running:"
	@echo ""
	@echo "cat $(PERSONAL_SSH_KEYS_HOME)/id_ed25519_$2.pub | $(COPY_TOOL)"
	@echo ""
	@echo "Open SSH page on $3"
	@echo "and paste copied public key"
	$(call write_git_ssh_config_entry,$3,,$(PERSONAL_SSH_KEYS_HOME)/id_ed25519_$2)
endef

.PHONY: bootstrap
bootstrap: check_os
	@echo "Bootstrapped everything!"

.PHONY: bootstrap_windows
bootstrap_windows: check_os
	@windows\bootstrap_windows.bat
	@echo "Bootstrapped windows!"

.PHONY: bootstrap_linux
bootstrap_linux: check_os link bootstrap_common
	@echo "Bootstrapped linux components!"

.PHONY: bootstrap_mac
bootstrap_mac: check_os link bootstrap_common oh_my_zsh homebrew install_brew_basics setup_mac_screenshots
	@echo "Bootstrapped mac components!"

.PHONY: bootstrap_common
bootstrap_common: check_os link_all_common prepare_projects_dir prepare_screenshots_dir prepare_scripts_cache_dir install_vim install_asdf alacritty_terminfo
	@echo "Bootstrapped common components!"

.PHONY: link
link: check_os clean_backup prepare_backup_dir
	@echo "Linked everything!"

.PHONY: link_all_common
link_all_common: check_os link_bin link_tmux link_screen link_git link_ctags link_vim link_apps_config link_tool_versions link_profile link_bash link_zsh
	@echo "Linked common files!"

.PHONY: link_all_mac
link_all_mac: check_os link_all_common
	@echo "Linked mac files!"

.PHONY: link_all_linux
link_all_linux: check_os link_all_common link_xconfig link_i3config
	@echo "Linked linux files!"

.PHONY: link_tmux
link_tmux: check_os
	@echo "Linking tmux files..."
	$(call link,tmux.conf,.tmux.conf)

.PHONY: link_screen
link_screen: check_os
	@echo "Linking screen files..."
	$(call link,screenrc,.screenrc)

.PHONY: link_git
link_git: check_os
	@echo "Linking git files..."
	$(call link,gitignore,.gitignore)
	$(call link,gitconfig,.gitconfig)
	$(call link,gitconfig.optimum,.gitconfig.optimum)

.PHONY: link_ctags
link_ctags: check_os
	@echo "Linking ctags files..."
	$(call link,ctags,.ctags)

.PHONY: link_vim
link_vim: check_os
	@echo "Linking vim files..."
	$(call link,vim,.vim)
	$(call link,ideavimrc,.ideavimrc)
	$(call link,vsvimrc,.vsvimrc)

.PHONY: link_apps_config
link_apps_config: check_os
	@echo "Linking apps config files..."
	$(call link,config,.config)

.PHONY: link_script_utils
link_script_utils: check_os
	@echo "Linking script_utils files..."
	@mkdir -p $(SCRIPTS_UTILS_DIR)
	$(call link,script_utils,.local/opt/script_utils)

.PHONY: link_tool_versions
link_tool_versions: check_os
	@echo "Linking tool-versions file for asdf"
	$(call link,tool-versions,.tool-versions)
	$(call link,config/asdf/.default-gems,.default-gems)

.PHONY: link_profile
link_profile: check_os
	@echo "Linking profile... (Don't forget to reboot or relogin due to .profile changes)"
	$(call link,profile.$(FILE_SUFFIX),.profile)

.PHONY: link_bash
link_bash: check_os
	@echo "Linking bash files..."
	$(call link,bashrc,.bashrc)

.PHONY: link_zsh
link_zsh: check_os
	@echo "Linking zsh files..."
	$(call link,zshrc.$(FILE_SUFFIX),.zshrc)

.PHONY: link_bin
link_bin: check_os
	@echo "Linking bin script files..."
	$(call link,bin,bin)

.PHONY: link_termux
link_termux: check_os link_apps_config
	@echo "Linking termux config files..."
	$(call link,config/termux,.termux)

.PHONY: link_xconfig
link_xconfig: check_os
	@echo "Linking X config files..."
	$(call link,zprofile,.zprofile)

.PHONY: link_i3config
link_i3config: check_os link_xconfig link_apps_config
	@echo "Linking i3 config files..."

# TODO Parametrize projects dir creation and automate gitconfig setup
.PHONY: prepare_projects_dir
prepare_projects_dir: check_os
	@echo "Creating projects directories"
	@mkdir -p $(PERSONAL_PROJECTS_ROOT)
	@mkdir -p $(PROJECTS_ROOT)/Optimum
	@mkdir -p $(DOCUMENTS_ROOT)/Personal
	@mkdir -p $(DOCUMENTS_ROOT)/Optimum
	@mkdir -p $(PRACTICE_PROJECTS_ROOT)

.PHONY: prepare_scripts_cache_dir
prepare_scripts_cache_dir: check_os
	@echo "Creating scripts cache directory"
	@mkdir -p $(SCRIPTS_CACHE_DIR)

.PHONY: clone_personal_vimwiki
clone_personal_vimwiki: check_os
	@echo "Cloning personal vimwiki"
	@git clone git@git.ensarsarajcic.com:esensar/vimwiki.wiki.git ~/vimwiki

.PHONY: clone_termux_shortcuts
clone_termux_shortcuts: check_os
	@echo "Cloning termux shortcuts"
	@git clone git@git.ensarsarajcic.com:esensar/termux-shortcuts.git ~/.shortcuts

.PHONY: prepare_ssh_dir
prepare_ssh_dir: check_os
	@echo "Creating ssh directories"
	@mkdir -p $(HOME)/.ssh/Personal

.PHONY: create_personal_ssh_keys
.ONESHELL:
create_personal_ssh_keys: check_os prepare_ssh_dir
	@echo "Creating personal ssh keys"
	@read -p "Enter your email: " email;
	$(call create_personal_git_ssh_key,$$email,personal_git,git.ensarsarajcic.com);
	$(call create_personal_git_ssh_key,$$email,codeberg,codeberg.org);
	$(call create_personal_git_ssh_key,$$email,sourcehut,git.sr.ht);
	$(call create_personal_git_ssh_key,$$email,github,github.com);

.PHONY: prepare_fish_shell
prepare_fish_shell: check_os
	@echo "Preparing fish shell..."
	@echo "Installing omf framework"
	@curl -L -k https://get.oh-my.fish | fish
	@echo "Install foreign-env to enable .profile in fish by running:"
	@echo ""
	@echo "omf install foreign-env"
	@echo ""

.PHONY: prepare_screenshots_dir
prepare_screenshots_dir: check_os
	@echo "Creating screenshots directories"
	@mkdir -p $(SCREENSHOTS_ROOT)

.PHONY: setup_mac_screenshots
setup_mac_screenshots: check_os prepare_screenshots_dir
	@echo "Configuring mac screenshots default location ($(SCREENSHOTS_ROOT))"
	@defaults write com.apple.screencapture location $(SCREENSHOTS_ROOT)

.PHONY: install_brew_basics
install_brew_basics: homebrew check_os
	@echo "Installig basic brew packages..."
	@brew bundle --file $(DOTFILES_DIR)/installed_packages/core/Brewfile

.PHONY: install_asdf
install_asdf: check_os
	@echo "Installing ASDF VM..."
	@git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0
	@echo "Installed ASDF Version 0.10.0"
	@echo "To install latest version:"
	@echo ""
	@echo "cd ~/.asdf"
	@echo "git fetch"
	@echo "git checkout \"$$\(git describe --abbrev=0 --tags\)\""
	@echo ""
	@echo "Consider installing configured ASDF tools:"
	@echo ""
	@echo ""
	@echo "Run in home directory:"
	@echo "asdf install"
	@echo ""
	@echo ""
	@echo "Consider installing ASDF plugins:"
	@echo "=================================="
	@echo "DIRENV:"
	@echo "----------------------------------"
	@echo "asdf plugin-add direnv"
	@echo "asdf install direnv latest"
	@echo ""
	@echo "Check out installed version using: "
	@echo "asdf list direnv"
	@echo ""
	@echo "Configure it as global using: "
	@echo "asdf global direnv $$version"
	@echo ""
	@echo "Configure it with provided function:"
	@echo "asdf direnv setup --shell fish --version latest"
	@echo ""
	@echo "When using in projects, put the following in .envrc: "
	@echo "use asdf"
	@echo "=================================="
	@echo ""

.PHONY: install_exercism
install_exercism: check_os
	@echo "Installing exercism..."
	@wget -O /tmp/exercism.tar.gz https://github.com/exercism/cli/releases/download/v3.0.13/exercism-3.0.13-linux-x86_64.tar.gz
	@tar -xf /tmp/exercism.tar.gz -C /tmp
	@mv /tmp/exercism ~/.local/bin/
	@read -p "Enter your exercism API KEY (https://exercism.org/settings/api_cli): " apikey;
	@echo "Configuring exercism..."
	exercism configure --token="$$apikey" --workspace="~/Projects/Personal/Mixed Technology/Practice/exercism"

.PHONY: install_vim
install_vim: check_os link_vim
	@echo "Vim package installation is no longer done automatically!"
	@echo "Start Vim or NeoVim and run:"
	@echo "For NeoVim: :PackerInstall"
	@echo "For Vim: :PlugInstall"

.PHONY: check_neovim
check_neovim: check_os
	@echo "This expects that packer is already installed"
	@echo "Installing packer packages"
	@nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerInstall'
	@echo "Doing a basic neovim startup and quit"
	@nvim --headless -c 'set display-=msgsep' -c 'quitall'
	@echo "Running plenary tests"
	@nvim --headless -c 'set display-=msgsep' -c 'PlenaryBustedDirectory symlinks/config/nvim/lua/tests'

.PHONY: run_tests
run_tests: check_os
	@echo "Running all tests from tests/"
	@./tests/run_all

.PHONY: oh_my_zsh
oh_my_zsh: check_os
	@echo "Installing oh-my-zsh..."
	@sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

.PHONY: oh_my_fish
oh_my_fish: check_os
	@echo "Installing oh-my-fish..."
	@curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
	@fish -c "omf install"

.PHONY: wallpapers_and_lockscreens
wallpapers_and_lockscreens: check_os
	@echo "Copying default wallpapers and lockscreens..."
	@mkdir -p $(WALLPAPERS_ROOT)
	@mkdir -p $(LOCKSCREENS_ROOT)
	@cp /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png $(WALLPAPERS_ROOT)
	@cp /usr/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png $(LOCKSCREENS_ROOT)

.PHONY: user_systemd_services
user_systemd_services: check_os
	@echo "Enabling user systemd services..."
	@echo "Please install and configure mbsync and vdirsyncer..."
	@systemd enable --now --user mbsync.timer
	@systemd enable --now --user vdirsyncer.timer

.PHONY: homebrew
homebrew: check_os
	@echo "Installing homebrew..."
	@/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

.PHONY: alacritty_terminfo
alacritty_terminfo: check_os
	@echo "Installing alacritty terminfo..."
	@echo tic $(SYMLINKS_DIR)/alacritty/alacritty.terminfo

.PHONY: prepare_backup_dir
prepare_backup_dir: check_os
	@echo "Creating $(BACKUP_DIR)"
	@mkdir -p $(BACKUP_DIR)

.PHONY: clean_backup
clean_backup: check_os
	@echo "Deleting $(BACKUP_DIR)"
	@rm -r $(BACKUP_DIR) || true

.PHONY: check_os
check_os:
	@echo "Running on $(UNAME)$(EXTRA_CI_MESSAGE)"

.PHONY: fail_with_unknown_host
fail_with_unknown_host:
	$(error Unkown host system!)

.PHONY: fail_with_bad_dotfiles_location
fail_with_bad_dotfiles_location:
	$(error Bad dotfiles location! Ensure dotfiles directory is found in $(DOTFILES_DIR)!)
