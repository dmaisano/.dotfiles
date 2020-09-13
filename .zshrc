### load zgen
source "${HOME}/.zgen/zgen.zsh"

### if the init script doesn't exist
if ! zgen saved; then

  ### specify plugins here
  zgen oh-my-zsh

  ### generate the init script from plugins above
  zgen save
fi

### specify plugins to load
zgen oh-my-zsh
zgen oh-my-zsh plugins/git
zgen oh-my-zsh plugins/sudo
zgen oh-my-zsh plugins/colored-man-pages
zgen oh-my-zsh plugins/command-not-found
zgen load zdharma/fast-syntax-highlighting
zgen load zsh-users/zsh-autosuggestions
zgen load lukechilds/zsh-nvm

### theme
zgen load denysdovhan/spaceship-prompt spaceship

### tilix
if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
  source /etc/profile.d/vte.sh
fi

### Custom aliases
alias zshconfig="code ~/.zshrc"
alias subl="subl3"

export DENO_INSTALL="~/.deno"
export PATH="$DENO_INSTALL/bin:$HOME/.cargo/bin:$PATH"
