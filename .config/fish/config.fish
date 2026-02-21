if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight
    starship init fish | source
end

set -gx XDG_CONFIG_HOME "$HOME/.config"

# see https://github.com/Schniz/fnm/issues/1119
set -gx XDG_RUNTIME_DIR /tmp/run/user/(id -u)
if not test -d $XDG_RUNTIME_DIR
    mkdir -p $XDG_RUNTIME_DIR
end

if test -f "$HOME/.config/fish/my_profile.fish"
    source "$HOME/.config/fish/my_profile.fish"
end

# https://direnv.net/docs/hook.html
if type -q direnv
    direnv hook fish | source
end
