# pyenv https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path "$PYENV_ROOT/bin"
pyenv init - | source
# fish_add_path "$PYENV_ROOT/shims"
# echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc

# pyenv init - https://gist.github.com/entropiae/326611addf6662d1d8fbf5792ab9a770#file-install-pyenv-on-ubuntu-18-04-fish-shell-L19
# set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
# if command -v pyenv 1>/dev/null 2>&1
#     pyenv init - | source
# end
