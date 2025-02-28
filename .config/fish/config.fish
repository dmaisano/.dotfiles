if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight
    starship init fish | source
end


fish_add_path /usr/local/sbin
fish_add_path $HOME/.local/bin


if test -f "$HOME/.config/fish/my_profile.fish"
    source "$HOME/.config/fish/my_profile.fish"
end

# https://direnv.net/docs/hook.html
if type -q direnv
    direnv hook fish | source
end
