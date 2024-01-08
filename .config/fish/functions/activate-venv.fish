function activate-venv --wraps='. venv/bin/activate.fish' --description 'alias activate-venv=. venv/bin/activate.fish'
  . venv/bin/activate.fish $argv
end
