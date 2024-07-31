function activate-venv --wraps='. venv/bin/activate.fish' --description 'alias activate-venv=. venv/bin/activate.fish'
    set -e _OLD_FISH_PROMPT_OVERRIDE
    set -e _OLD_VIRTUAL_PYTHONHOME
    set -e _OLD_VIRTUAL_PATH
    . venv/bin/activate.fish $argv
end
