#!/usr/bin/fish

# NOTE: add the fish shell PPA if running on Ubuntu
# sudo apt-add-repository ppa:fish-shell/release-3

set REPO_ROOT_DIR (realpath (dirname (dirname (status filename))))
set SCRIPT_DIR (realpath (dirname (status filename)))

function setup_fnm
  set -l BASE_FILE_NAME "fnm_install"
  echo -e "⏳ Installing fnm -- 🚀 Fast and simple Node.js version manager, built in Rust\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

  curl -fsSL https://fnm.vercel.app/install > $SCRIPT_DIR/$BASE_FILE_NAME.sh
  bash $SCRIPT_DIR/$BASE_FILE_NAME.sh --install-dir "$HOME/.fnm" > "$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt" 2>&1 &
  wait

  # ? handle any errors
  set -l matches (string match -r -i -g -- "(unzip)\.\.\. missing" (cat "$SCRIPT_DIR/$BASE_FILE_NAME"_output.txt))
  if test (count $matches) -gt 0
    for match in $matches
      echo "❌ Error installing fnm: missing dependency '$match'"
    end
  end
end


function setup_git
  read -l -P "🐙 Enter git username: " username
  read -l -P "📧 Enter git email addreess: " email

  git config --global user.name $username
  git config --global user.email $email
  git config --global credential.helper 'store --file ~/.my-credentials'
  git config --global core.editor "code --wait"
  git config --global init.defaultBranch main
end


function setup_oh_my_fish
  set -l BASE_FILE_NAME "omf_install"
  set OMF_PATH "$HOME/.local/share/omf"
  echo -e "⏳ Installing oh-my-fish -- 🐠 The Fish Shell Framework\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

  curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > "$SCRIPT_DIR/$BASE_FILE_NAME"".fish"
  fish "$SCRIPT_DIR/$BASE_FILE_NAME"".fish" --noninteractive --path=$OMF_PATH --config=~/.config/omf > omf_install_output.txt 2>&1 &
  wait

  sleep 1.5 && source $OMF_PATH/init.fish
  echo "⏳ Running 'omf install'..."
  omf install &
  wait
end


function setup_python
  echo "⏳ Installing pyenv 🐍"
  curl https://pyenv.run | bash & # pyenv-virtualenv plugin is installed by default
  wait
end


function setup_starship
  set -l BASE_FILE_NAME "starship_install"
  echo "⏳ Installing starship -- 💫 The minimal, blazing-fast, and infinitely customizable prompt for any shell\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

  curl -fsSL https://starship.rs/install.sh > $SCRIPT_DIR/$BASE_FILE_NAME.sh
  bash $SCRIPT_DIR/$BASE_FILE_NAME.sh -y > "$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt" 2>&1 &
  wait
end


function setup_symlinks
  stow --adopt *
  git restore .
end


function reset_dotfiles
  set folder_names (ls $REPO_ROOT_DIR/.config) ~/{.oh-my-zsh, .zshrc} ~/.local/share/{fish, omf}
  echo -e "⛔ Hold on pardner! 🤠 The following folders will be deleted:\n$(set_color bryellow)$folder_names$(set_color normal)"
  read -l -P "Do you wish to continue? $(set_color bryellow)(y/N)$(set_color normal): " confirmation

  if test (string trim -c " " -- (string lower -- $confirmation)) = "y"
    echo "📁 Deleting folders..."
    rm -rf $folder_names
  else
    echo "👍 No changes made!"
  end
end


function main
  # ? Intention is to run one function at a time. Restarting the shell maybe be required as needed
  if test (count $argv) -eq 0
      echo "Missings arguments. Please specify at least one of the following options: fnm, git, omf, python, starship, symlinks, $(set_color bryellow)reset$(set_color normal)."
      exit 1
  end

  # TODO - better argparse logic with flag options

  if contains "fnm" $argv
      setup_fnm
   else if contains "git" $argv
    setup_git
   else if contains "omf" $argv
      setup_oh_my_fish
  else if contains "python" $argv
      setup_python
  else if contains "starship" $argv
      setup_starship
  else if contains "symlinks" $argv
      setup_symlinks
  else if contains "reset" $argv
      reset_dotfiles
  end

  echo "Please remember to start a new shell instance when done! 🐚"
end

main $argv
