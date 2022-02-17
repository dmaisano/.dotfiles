#!/usr/bin/fish

curl -fsSL https://fnm.vercel.app/install | bash

rm -f "$HOME/.config/fish/conf.d/fnm.fish"
ln -sfn "$PWD/.config/fish/conf.d/fnm.fish" "$HOME/.config/fish/conf.d/fnm.fish"

source /home/dmaisano/.config/fish/conf.d/fnm.fish

mkdir -p $PWD/.config/fish/completions

fnm completions --shell=fish > $PWD/.config/fish/completions/fnm.fish

ln -sfn "$PWD/.config/fish/completions/fnm.fish" "$HOME/.config/fish/completions/fnm.fish"
