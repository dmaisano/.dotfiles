if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight

    starship init fish | source
end

# set -gx NVM_DIR ~/.nvm
# function nvm
#     bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
# end

fish_add_path /usr/local/sbin

# alias python="/usr/local/bin/python3"

# Delete all local branches except master or current working branch
function gbr
    git branch | grep -Ev "master|(git branch --show-current)" | xargs git branch -D
end

# set DISPLAY variable to the IP automatically assigned to WSL2
set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
# Automatically start dbus
sudo /etc/init.d/dbus start &> /dev/null

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
