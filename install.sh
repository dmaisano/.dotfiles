RED="\033[0;31m"

# No color
NC="\033[0m"


# Install Antigen
# https://github.com/zsh-users/antigen
curl -L git.io/antigen > $HOME/.dotfiles/antigen.zsh

# Overwrite the existing zsh config file
if [[ ! -f "$HOME/.zshrc" ]]; then
  echo "$RED Making backup of"
fi

# Linux specific config
if [ $OSTYPE == "linux-gnu" ]; then
  if [ ! -d "$HOME/.config/tilix/schemes" ]; then
    mkdir -p "$HOME/.config/tilix/schemes"
  fi

  cp -R $HOME/.dotfiles/.config/tilix/schemes/* "$HOME/.config/tilix/schemes"

  echo "Copied Tilix color schemes"
fi
