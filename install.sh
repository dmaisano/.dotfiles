#!/usr/bin/env bash

### colors
RED="\e[1;31m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
RESET="\e[0m"

git --version > /dev/null 2>&1
git_exists=$?

fira_code_install() {
  echo -e "📥 Downloading Fira Code font: ${BLUE}https://github.com/tonsky/FiraCode${RESET}"
  fonts_dir="${HOME}/.local/share/fonts"
  if [ ! -d "${fonts_dir}" ]; then
      echo "mkdir -p $fonts_dir"
      mkdir -p "${fonts_dir}"
  else
      echo -e "Found fonts dir ${GREEN}$fonts_dir${RESET}"
  fi

  for type in Bold Light Medium Regular Retina; do
      file_path="${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
      file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
      if [ ! -e "${file_path}" ]; then
          echo -e "wget -O ${GREEN}$file_path ${BLUE}$file_url${RESET}"
          wget -q -O "${file_path}" "${file_url}"
      else
    echo -e "Found existing file ${GREEN}$file_path${RESET}"
      fi;
  done

  echo "fc-cache -f"
  fc-cache -f
}

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

  tilix --version > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    ### load tilix profile
    dconf load /com/gexperts/Tilix/ < .config/tilix/tilix.dconf
  fi

  fira_code_install
}

main() {
  if [ -f "$HOME/.zshrc" ]; then
    echo -e "${YELLOW}Making backup of existing ${GREEN}.zshrc ⚠️${RESET}"
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  ln -s $HOME/.dotfiles/.zshrc $HOME/.zshrc

  ### install zgen
  if [ ! -d  $"{HOME}/.zgen" ]; then
    echo -e "📥 Downloading zgen: ${BLUE}https://github.com/tarjoilija/zgen${RESET}"
    git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
  fi

   ### native linux (excludes WSL)
  if [ "$OSTYPE" = "linux-gnu" ] && ! grep -qi "microsoft" /proc/version; then
    linux_config
  fi

  if [ $git_exists -eq 0 ]; then
    read -p "Configure global git credentials? [y/N]: " git_prompt

    if [[ ${git_prompt,,} =~ \s*"y"\s* ]]; then
      read -p "Enter git username: " git_username
      git config --global user.name $git_username

      read -p "Enter git email: " git_user_email
      git config --global user.email $git_user_email

      git config --global credential.helper 'store --file ~/.git-credentials'
    fi
  fi

  echo "Done ✅"
}

main
