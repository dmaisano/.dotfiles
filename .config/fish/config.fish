if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight

    starship init fish | source
end

set -gx IS_WSL 0
if test (grep -i Microsoft /proc/version)
    set -gx IS_WSL 1
end

set -gx IS_MAC 0

if test $IS_WSL -eq 1
    # set DISPLAY variable to the IP automatically assigned to WSL2
    set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    # Automatically start dbus
    sudo /etc/init.d/dbus start &> /dev/null
end

# set -gx NVM_DIR ~/.nvm
# function nvm
#     bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
# end

fish_add_path /usr/local/sbin

# alias python="/usr/local/bin/python3"

# run a typescript file with applicable dotenv config
function ts_script
    npx ts-node -r dotenv/config $argv
end

# Delete all local branches except master or current working branch
function gbr
    git branch | grep -Ev "master|(git branch --show-current)" | xargs git branch -D
end

# pnpm
# set -gx PNPM_HOME "/home/virtualdom/.local/share/pnpm"
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
set -gx PATH "$PNPM_HOME" $PATH
# pnpm end
