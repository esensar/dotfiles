REM First move over old files to backup
mkdir %UserProfile%\vimbak
mkdir %UserProfile%\gitbak
move %UserProfile%\_vimrc %UserProfile%\vimbak
move %UserProfile%\.ideavimrc %UserProfile%\vimbak
move %UserProfile%\.vsvimrc %UserProfile%\vimbak
move %UserProfile%\vimfiles %UserProfile%\vimbak
move %UserProfile%\.gitconfig %UserProfile%\gitbak
move %UserProfile%\.gitignore %UserProfile%\gitbak
type NUL > %UserProfile%\.gitconfig.local

REM Then link new files in
mklink %UserProfile%\_vimrc %~dp0..\symlinks\vimrc
mklink %UserProfile%\.ideavimrc %~dp0..\symlinks\ideavimrc
mklink %UserProfile%\.vsvimrc %~dp0..\symlinks\vsvimrc
mklink /D %UserProfile%\vimfiles %~dp0..\symlinks\vim
mklink %UserProfile%\.gitconfig %~dp0..\symlinks\gitconfig
mklink %UserProfile%\.gitignore %~dp0..\symlinks\gitignore
mklink /D %UserProfile%\AppData\Local\nvim %~dp0..\symlinks\config\nvim

REM Then set up vim plug
Powershell.exe -executionpolicy remotesigned -File  %~dp0install_vim_plug_windows.ps1
