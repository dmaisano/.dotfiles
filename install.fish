#!/usr/local/bin/fish

rm -rf "$HOME/.config/starship.toml"
rm -rf "$HOME/.config/fish"
rm -rf "$HOME/.config/omf"
rm -rf "$HOME/.local/share/omf"

curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install > omf_install
fish omf_install --noninteractive --path=~/.local/share/omf --config=~/.config/omf

source ~/.local/share/omf/init.fish

ln -sfn "$PWD/.config/omf/bundle" "$HOME/.config/omf/bundle"
ln -sfn "$PWD/.config/omf/channel" "$HOME/.config/omf/channel"
ln -sfn "$PWD/.config/omf/theme" "$HOME/.config/omf/theme"

eval "omf install"

ln -sfn "$PWD/.config/starship.toml" "$HOME/.config/starship.toml"
ln -sfn "$PWD/.config/fish/config.fish" "$HOME/.config/fish/config.fish"

eval "omf reload"
