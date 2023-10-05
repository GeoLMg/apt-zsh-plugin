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
            #  sudo apt install $0 -y; 
            new_exeption $0;
            ;;
        *)
            exit
            ;;
    esac
  }
  
  function new_exeption() {
    declare myVar="$1"
    shift 1
   if ! sudo apt install $myVar -y; then
      echo "\nTry to find command in other packages..."
      python3 $ZSH/plugins/apt/find.py $myVar 
      $myVar
      else $myVar
   fi
  }