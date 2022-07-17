#!/bin/bash

declare -A SKIP=()
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -s|--skip)
      shift # past argument
      SKIP["$1"]=1
      shift # past value
      ;;
    *)    # unknown option
      POSITIONAL+=("$1") # save it in an array for later
      shift # past argument
      ;;
  esac
done

declare -A RUN=()

for command in "pacman" "apt" "dnf" "flatpak" "gem" "nvim" "asdf" "brew" "pacman" "pip" "pip2" "pip3";
do
	if type $command > /dev/null 2>&1
	then
		if [ "${SKIP[$command]}" = "1" ]; then
			RUN[$command]=0
		else
			RUN[$command]=1
		fi
	else
		RUN[$command]=0
	fi
done

# Special case for vim
if type -f vim > /dev/null 2>&1
then
	if [ "${SKIP[vim]}" = "1" ]; then
		RUN[vim]=0
	else
		RUN[vim]=1
	fi
else
	RUN[vim]=0
fi

export SKIP=$SKIP
export RUN=$RUN
export POSITIONAL=$POSITIONAL
