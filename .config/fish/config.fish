if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight
    starship init fish | source
end

source "$HOME/.config/fish/asdf.fish"
source "$HOME/.config/fish/os.fish"
source "$HOME/.config/fish/macros.fish"
source "$HOME/.config/fish/nodejs.fish"
source "$HOME/.config/fish/work_profile.fish"
# source "$HOME/.config/fish/python.fish"

fish_add_path /usr/local/sbin

# https://direnv.net/docs/hook.html
if type -q direnv
    direnv hook fish | source
end

set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.local/share/JetBrains/Toolbox/scripts/" $PATH
set -gx PATH "$HOME/.lmstudio/bin" $PATH
