#!/bin/bash

### colors
RED="\e[1;31m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
RESET="\e[0m"

linux_config() {
  if [ ! -d "$HOME/.config/tilix/schemes" ]; then
    mkdir -p "$HOME/.config/tilix/schemes"
  fi

  cp -R $HOME/.dotfiles/.config/tilix/schemes/* "$HOME/.config/tilix/schemes"

  ### check if Ubuntu based distro
  if echo $(uname -a) | grep -iqF "ubuntu" && [ ! -L /etc/profile.d/vte.sh ]; then
    echo -e "${YELLOW}Creating the following symlink: ${GREEN}/etc/profile.d/vte-2.91.sh ${RESET}➡️ ${GREEN}/etc/profile.d/vte.sh${RESET}"
    sudo ln -s /etc/profile.d/vte-2.91.sh /etc/profile.d/vte.sh
  fi

  read -p "Configure global git credentials? [y/N]: " git_prompt

  if [[ ${git_prompt,,} =~ \s*"y"\s* ]]; then
    read -p "Enter git username: " git_username
    git config --global user.name $git_username

    read -p -s "Enter git email: " git_user_email
    git config --global user.email $git_user_email

    git config --global credential.helper 'store --file ~/.git-credentials'
  fi
}

main() {
  if [ -f "$HOME/.zshrc" ]; then
    echo -e "${YELLOW}Making backup of existing ${GREEN}.zshrc ⚠️${RESET}"
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  cp ".zshrc" "$HOME/.zshrc"

  if [ "$OSTYPE" = "linux-gnu" ]; then
    linux_config
  fi

  echo "Done ✅"
}

main
