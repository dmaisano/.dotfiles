#!/usr/bin/fish

set oldIFS "$IFS"
set IFS ""
set fnm_install_output (curl -fsSL https://fnm.vercel.app/install | bash -s -- --install-dir "$HOME/.fnm")
wait $last_pid

if string match -r -q 'Not installing fnm due to missing dependencies' $fnm_install_output
  exit 1
end

set fnm_config_dir "$HOME/.config/fish"

rm -f "$fnm_config_dir/conf.d/fnm.fish"
ln -sfn "$PWD/.config/fish/conf.d/fnm.fish" "$fnm_config_dir/conf.d/fnm.fish"

source "$fnm_config_dir/conf.d/fnm.fish"

set fnm_completions_dir "$PWD/.config/fish/completions"
mkdir -p "$fnm_completions_dir" "$fnm_config_dir/completions"
fnm completions --shell=fish > "$fnm_completions_dir/fnm.fish"
ln -sfn "$fnm_completions_dir/fnm.fish" "$fnm_config_dir/completions/fnm.fish"
