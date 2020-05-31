#!/bin/bash

# COLORS
RED="\e[1;31m"
YELLOW="\e[1;33m"
GREEN="\e[1;32m"
BLUE="\e[1;34m"
NC="\e[0m"

linux_config() {
  if [ ! -d "$HOME/.config/tilix/schemes" ]; then
    mkdir -p "$HOME/.config/tilix/schemes"
  fi

  cp -R $HOME/.dotfiles/.config/tilix/schemes/* "$HOME/.config/tilix/schemes"
}

main() {
  echo "foo"
  if [ -f "$HOME/.zshrc" ]; then
    echo -e "${YELLOW}Making backup of existing ${GREEN}.zshrc ⚠️${NC}"

    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  cp ".zshrc" "$HOME/.zshrc"

  if [ "$OSTYPE" = "linux-gnu" ]; then
    linux_config
  fi

  echo "Done ✅"
}

main
