#!/bin/bash

### * configure git credentials
read -p "☁️  Configure global git credentials? [y/N]: " git_prompt

shopt -s nocasematch
if [ "$git_prompt" == "y" ]; then
  read -p "🧔 Enter git username: " git_username
  git config --global user.name $git_username

  read -p "📧 Enter git email: " git_user_email
  git config --global user.email $git_user_email

  git config --global credential.helper 'store --file ~/.git-credentials'
fi
