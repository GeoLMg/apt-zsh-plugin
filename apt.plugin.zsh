#!/bin/zsh
function command_not_found_handler() {
  RED='\033[0;31m'
  Green='\033[0;32m' 
  NC='\033[0m' # No Color
  echo -en "${RED}Command \"$0\" not found${NC}.\nDo you want to install it? [${Green}y$NC|${RED}N$NC]: "
  read -k yn
  echo ""
  case $yn in
    [дД]|[yY]|[eE]|[sS]|[yY]*|[jJ]*)
             sudo apt install $0 -y
            ;;
        *)
            exit
            ;;
    esac
  }