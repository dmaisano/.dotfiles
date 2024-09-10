if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight
    starship init fish | source
end

source "$HOME/.config/fish/os.fish"
source "$HOME/.config/fish/macros.fish"
source "$HOME/.config/fish/nodejs.fish"
# source "$HOME/.config/fish/python.fish"

fish_add_path /usr/local/sbin

# https://direnv.net/docs/hook.html
direnv hook fish | source

set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.local/share/JetBrains/Toolbox/scripts/" $PATH
