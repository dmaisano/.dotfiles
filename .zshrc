### * load zgen
source "${HOME}/.zgen/zgen.zsh"

### * runs if the init script doesn't exist
if ! zgen saved; then

  ### * specify plugins here
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/colorize
  zgen oh-my-zsh plugins/git
  # zgen oh-my-zsh plugins/nvm
  # zgen oh-my-zsh plugins/npm
  zgen oh-my-zsh plugins/rust
  zgen oh-my-zsh plugins/colored-man-pages
  zgen oh-my-zsh plugins/command-not-found
  # zgen load lukechilds/zsh-nvm
  # zgen load lukechilds/zsh-better-npm-completion

  ### * theme
  # zgen load spaceship-prompt/spaceship-prompt spaceship

  ### * quality of life stuff
  # zgen load zsh-users/zsh-autosuggestions
  # zgen load zdharma-continuum/fast-syntax-highlighting

  ### generate the init script from plugins above
  zgen save
fi

ZSH_AUTOSUGGEST_MANUAL_REBIND=true

### * custom aliases
alias zshconfig="code ~/.zshrc"

if [ -d "${HOME}/.deno" ]; then
  export DENO_INSTALL="~/.deno"
  export PATH="$DENO_INSTALL/bin:$HOME/.cargo/bin:$PATH"
fi

### * custom vars
export NVM_DIR="$HOME/.nvm"

### * path stuff
if [[ "$OSTYPE" == "darwin"* ]]; then
  [ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && \. "$(brew --prefix)/opt/nvm/nvm.sh"                                       # This loads nvm
  [ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && \. "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
  export PATH="/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
fi

export PATH="/usr/local/sbin:$PATH"

### * theme
eval "$(starship init zsh)"
