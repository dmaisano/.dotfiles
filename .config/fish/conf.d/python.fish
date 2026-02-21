set -gx PYENV_ROOT $HOME/.pyenv
fish_add_path $PYENV_ROOT/bin

if type -q pyenv
    pyenv init - fish | source
    status --is-interactive; and pyenv virtualenv-init - | source
end
