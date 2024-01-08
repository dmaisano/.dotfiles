function activate-env --wraps='. venv/bin/activate.fish' --description 'alias activate-env=. venv/bin/activate.fish'
  . venv/bin/activate.fish $argv

end
