#!/usr/bin/fish

# NOTE: add the fish shell PPA if running on Ubuntu
# sudo apt-add-repository ppa:fish-shell/release-3

# function symlink_sync
#   set symlink_src_dirs "$PWD/.config/" "$PWD/.oh-my-zsh"

#   for source_dir in $symlink_src_dirs
#     for entry in (find "$source_dir" -type f -o -type d)
#       set destination (string replace $PWD $HOME $entry)

#       if not test -d (dirname $destination)
#         mkdir -p (dirname $destination)
#       end

#       if test -f $entry
#         ln -sfn $entry $destination
#       end
#     end
#   end
# end

function setup_fnm
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm" > fnm_install_output.txt 2>&1 &
  wait

  set -l matches (string match -r -i -g -- "(unzip)\.\.\. missing" (cat fnm_install_output.txt))
  if test (count $matches) -gt 0
    for match in $matches
      echo "❌ Error installing fnm: missing dependency '$match'"
    end
  else
    set fnm_config_dir "$HOME/.config/fish"
    ln -sfn "$PWD/.config/fish/*" "$fnm_config_dir"
  end
end

function setup_starship
  curl -sS https://starship.rs/install.sh > starship_install.sh &
  wait
  echo "⏳ Installing starship prompt 🚀 Check \"$PWD/starship_install_output.txt\" for more details."
  sh starship_install.sh -y > starship_install_output.txt 2>&1 &
  wait
end

function setup_python
  echo "Installing pyenv 🐍"
  curl https://pyenv.run | bash & # pyenv-virtualenv plugin is installed by default
  wait
  source "$HOME/.config/fish/python-stuff.fish"
end

function setup_fish_shell
  echo "⏳ Installing oh-my-fish. Check \"$PWD/omf_install_output.txt\" for more details."
  curl -sS https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install.sh &
  wait

  fish omf_install.sh --noninteractive --path=~/.local/share/omf --config=~/.config/omf > omf_install_output.txt 2>&1 &
  wait

  echo '💡 Please execute "omf install" and "omf reload" manually in a new fish shell instance.'
end

function main
  # ? Intention is to run one function at a time. Restarting the shell maybe be required to run the next function.
  if test (count $argv) -eq 0
      echo "Missings arguments. Please specify at least one of the following options: fnm, starship, python, fish"
      exit 1
  end

  if contains "fnm" $argv
      setup_fnm
  else if contains "starship" $argv
      setup_starship
  else if contains "python" $argv
      setup_python
  else if contains "fish" $argv
      setup_fish_shell
  end
end

main $argv
