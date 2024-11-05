#!/bin/zsh
function command_not_found_handler() {
  current_language=$(echo $LANG | cut -d_ -f1)
  RED='\033[0;31m'
  Green='\033[0;32m' 
  NC='\033[0m' # No Color
  # Проверяем язык и выводим соответствующий текст
  case "$current_language" in
      en)
          echo -en "${RED}Command${NC} \"$0\" ${RED}not found${NC}.\nDo you want to install it? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      ru)
          echo -en "${RED}Команда${NC} \"$0\" ${RED}не найдена${NC}.\nХотите установить её? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      es)
          echo -en "${RED}Comando${NC} \"$0\" ${RED}no encontrado${NC}.\n¿Quieres instalarlo? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      fr)
          echo -en "${RED}Commande${NC} \"$0\" ${RED}non trouvée${NC}.\nVoulez-vous l'installer? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      hy)
          echo -en "${RED}Հրաման${NC} \"$0\" ${RED}չի գտնվել${NC}.\Ցանկանում եք այն տեղադրել? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      de)
          echo -en "${RED}Befehl${NC} \"$0\" ${RED}nicht gefunden${NC}.\nMöchten Sie es installieren? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      it)
          echo -en "${RED}Comando${NC} \"$0\" ${RED}non trovato${NC}.\nVuoi installarlo? [${GREEN}y${NC}/${RED}N${NC}]: "
          ;;
      *)
          echo -en "${RED}Command${NC} \"$0\" ${RED}not found${NC}.\nDo you want to install it? [${GREEN}y${NC}/${RED}N${NC}]: "  # По умолчанию на английском
          ;;
  esac
  read -k yn
  echo ""
  case $yn in
    [дД]|[yY]|[eE]|[sS]|[այ]*|[yY]*|[jJ]*)
            #  sudo apt install $0 -y; 
            new_exeption $0;
            ;;
        *)
            exit
            ;;
    esac
  }
  
  function new_exeption() {
    declare app_name="$1"
    shift 1
   if ! sudo apt install $app_name -y; then
      case "$current_language" in
    en)
        echo -e "\nTrying to find command in other packages..."
        ;;
    ru)
        echo -e "\nПопытка найти команду в других пакетах..."
        ;;
    es)
        echo -e "\nIntentando encontrar el comando en otros paquetes..."
        ;;
    fr)
        echo -e "\nEssayer de trouver la commande dans d'autres paquets..."
        ;;
    hy)
        echo -e "\nԱյլ փաթեթներում հրաման գտնելու փորձ..."
        ;;
    de)
        echo -e "\nVersuche, den Befehl in anderen Paketen zu finden..."
        ;;
    it)
        echo -e "\nCercando di trovare il comando in altri pacchetti..."
        ;;
    *)
        echo -e "\nTrying to find command in other packages..."  # По умолчанию на английском
        ;;
      esac
      python3 $ZSH/plugins/apt/find.py $app_name
      if [ $? -ne 0 ]; then
        case "$current_language" in
          en)
              echo -e "\n${RED}Error:${NC} No package found"
              ;;
          ru)
              echo -e "\n${RED}Ошибка:${NC} Пакет не найден"
              ;;
          es)
              echo -e "\n${RED}Error:${NC} No se encontró el paquete"
              ;;
          fr)
              echo -e "\n${RED}Erreur:${NC} Aucun paquet trouvé"
              ;;
          hy)
              echo -e "\n${RED}Սխալ:${NC} Փաթեթը չի գտնվել"
              ;;
          de)
              echo -e "\n${RED}Fehler:${NC} Kein Paket gefunden"
              ;;
          it)
              echo -e "\n${RED}Errore:${NC} Nessun pacchetto trovato"
              ;;
          *)
              echo -e "\n${RED}Error:${NC} No package found"  # По умолчанию на английском
              ;;
        esac
        return 1
      fi
      echo "Запуск"
        if ! type "$app_name" > /dev/null; then
            return 1
        fi
      $app_name
      else
        if ! type "$app_name" > /dev/null; then
            return 1
        fi
        $app_name

   fi
  }

function upgrading_system () {
    RED='\033[0;31m'
    Green='\033[0;32m' 
    NC='\033[0m' # No Color
    SECONDS=0

    notify-send "Starting updating system"
    echo -e "${RED}APT${NC}: Updating repos..."
    sudo apt update 1> /dev/null
    echo -e "${RED}APT${NC}: Updating packages..."
    sudo apt upgrade -y
    echo -e "${RED}APT${NC}: Autoremoving packages..."
    sudo apt autoremove -y
    echo -e "\e${RED}APT${NC}: Autoremoving packages...done"
    if  type "flatpak" &> /dev/null; then
        echo -e "${RED}FLATPAK${NC}: Updating..."
        sudo flatpak -y update
    fi
    if  type "snap" &> /dev/null; then
        echo -e "${RED}SNAP${NC}: updating..."
        sudo snap refresh
    fi
    duration=$SECONDS
    echo -e "All updated in $((duration / 60)) minutes"
    notify-send "All updated in $((duration / 60)) minutes"
}
  alias upall="upgrading_system"