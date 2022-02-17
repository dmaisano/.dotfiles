#!/bin/bash

main() {
  echo "⌛ Running first-time install script..."

  ### * install zgen if not exists
  if [ ! -d "${HOME}/.zgen" ]; then
    echo "📥 Downloading zgen (source: https://github.com/tarjoilija/zgen)..."
    git clone https://github.com/tarjoilija/zgen "${HOME}/.zgen"
  fi

  if [ -f "$HOME/.zshrc" ]; then
    echo -e "Backing up existing .zshrc file..."
    cp "$HOME/.zshrc" "$HOME/.zshrc.bak"
  fi

  echo "🔗 Creating symlink between $PWD/.zshrc -> $HOME/.zshrc"
  ln -sf $PWD/.zshrc $HOME/.zshrc

  echo "✅ Done"
}

main
