#!/bin/bash

### ? clone this repo to your home folder
### ? ~/.dotfiles

git --version >/dev/null 2>&1
git_exists=$?

main() {
  echo "⌛ Running first-time install script..."

  if [ $git_exists -eq 0 ]; then
    ### * install zgen if not exists
    if [ ! -d "${HOME}/.zgen" ]; then
      echo "📥 Downloading zgen (source: https://github.com/tarjoilija/zgen)..."
      git clone https://github.com/tarjoilija/zgen "${HOME}/.zgen"
    fi

    ### * configure git credentials
    read -p "☁️  Configure global git credentials? [y/N]: " git_prompt

    shopt -s nocasematch
    if [ $git_prompt == "y" ]; then
      read -p "🧔 Enter git username: " git_username
      git config --global user.name $git_username

      read -p "🔑 Enter git email: " git_user_email
      git config --global user.email $git_user_email

      git config --global credential.helper 'store --file ~/.git-credentials'
    fi
  fi

  if [ -f "$HOME/.zshrc" ]; then
    echo -e "Backing up existing .zshrc file..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  echo "🔗 Creating symlink between $PWD/.zshrc -> $HOME/.zshrc"
  ln -sf $PWD/.zshrc $HOME/.zshrc

  source $HOME/.zshrc

  echo "✅ Done"
}

main
