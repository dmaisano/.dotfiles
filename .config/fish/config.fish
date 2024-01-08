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
    # ensure user has sudo privledges
    # https://www.simplehelp.net/2009/05/27/how-to-stop-ubuntu-from-asking-for-your-sudo-password/

    # https://x410.dev/cookbook/wsl/sharing-dbus-among-wsl2-consoles/

    # set DISPLAY variable to the IP automatically assigned to WSL2
    # set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    # Automatically start dbus
    # sudo /etc/init.d/dbus start &> /dev/null
end

# set -gx NVM_DIR ~/.nvm
# function nvm
#     bass source (brew --prefix nvm)/nvm.sh --no-use ';' nvm $argv
# end

# rust
# bass source "$HOME/.cargo/env"

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
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pyenv https://github.com/pyenv/pyenv?tab=readme-ov-file#set-up-your-shell-environment-for-pyenv
set -gx PYENV_ROOT "$HOME/.pyenv"
fish_add_path "$PYENV_ROOT/bin"
pyenv init - | source
# fish_add_path "$PYENV_ROOT/shims"
# echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init --path)"\nfi' >> ~/.bashrc
# pyenv end

# pyenv init - https://gist.github.com/entropiae/326611addf6662d1d8fbf5792ab9a770#file-install-pyenv-on-ubuntu-18-04-fish-shell-L19
# set -U fish_user_paths $HOME/.pyenv/bin $fish_user_paths
# if command -v pyenv 1>/dev/null 2>&1
#     pyenv init - | source
# end

# https://direnv.net/docs/hook.html
# direnv hook fish | source

source "$HOME/.config/fish/abbreviations.fish"
