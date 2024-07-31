# Enable virtualenv autocomplete
if command -q pyenv
    status --is-interactive; and pyenv init - | source
    status --is-interactive; and pyenv virtualenv-init - | source
end
