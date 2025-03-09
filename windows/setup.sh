#!/bin/bash

REPO_ROOT_DIR=$(realpath "$(dirname "$(dirname "${BASH_SOURCE[0]}")")")

if [[ $1 == "git" ]]; then
  read -p "🐙 Enter git username: " username
  read -p "📧 Enter git email address: " email

  git config --global user.name "$username"
  git config --global user.email "$email"
  git config --global core.editor "code --wait"
  git config --global init.defaultBranch main
fi

if [[ $1 == "git-bash" ]]; then
  cp "$REPO_ROOT_DIR/windows/.bashrc" "$HOME/.bashrc"
  cp "$REPO_ROOT_DIR/windows/.bash_profile" "$HOME/.bash_profile"
fi

if [[ $1 == "starship" ]]; then
  mkdir -p "$HOME/.local/bin" "$HOME/.config"
  curl -sS https://starship.rs/install.sh | sh -s -- --yes --bin-dir "$HOME/.local/bin"
  cp "$REPO_ROOT_DIR/.config/starship.toml" "$HOME/.config/starship.toml"
fi

if [[ $1 == "direnv" ]]; then
  winget install direnv
fi

if [[ $1 == "pyenv" ]]; then
  mkdir -p "$HOME/.pyenv"
  git clone https://github.com/pyenv-win/pyenv-win.git "$HOME/.pyenv"
fi
