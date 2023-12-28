#!/usr/bin/fish

# if not test $USER = "root"
#     echo "This script must be run as root! user"
#     exec sudo fish $argv[1]
# end

function symlink_sync
  set symlink_src_dirs "$PWD/.config/" "$PWD/.oh-my-zsh"

  for source_dir in $symlink_src_dirs
    for entry in (find "$source_dir" -type f -o -type d)
      set destination (string replace $PWD $HOME $entry)

      if not test -d (dirname $destination)
        mkdir -p (dirname $destination)
      end

      if test -f $entry
        ln -sfn $entry $destination
      end
    end
  end
end

function setup_fnm
  curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm" > fnm_install_output.txt 2>&1 &
  wait

  if grep -q "Not installing" "$PWD/fnm_install_output.txt"
      echo "❌ Error installing fnm. Check \"$PWD/fnm_install_output.txt\" for more details."
      exit 0
  end

  set fnm_config_dir "$HOME/.config/fish"
  ln -sfn "$PWD/.config/fish/*" "$fnm_config_dir"
end

function setup_fish_shell
  echo "⏳ Installing oh-my-fish. Check \"$PWD/omf_install_output.txt\" for more details."
  curl -sS https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install &
  wait

  fish omf_install --noninteractive --path=~/.local/share/omf --config=~/.config/omf > omf_install_output.txt 2>&1 &
  wait

  echo '💡 Please execute "omf install" and "omf reload" manually in a new fish shell instance.'
end

function setup_starship
  curl -sS https://starship.rs/install.sh > starship_install.sh &
  wait
  echo "⏳ Installing starship prompt 🚀 Check \"$PWD/starship_install_output.txt\" for more details."
  sh starship_install.sh -y > starship_install_output.txt 2>&1 &
  wait
end

symlink_sync
setup_fnm
setup_starship
setup_fish_shell

