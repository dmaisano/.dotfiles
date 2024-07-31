if status is-interactive
    ### Commands to run in interactive sessions can go here
    scheme set tokyonight

    starship init fish | source
end

source "$HOME/.config/fish/os.fish"
source "$HOME/.config/fish/macros.fish"
source "$HOME/.config/fish/python.fish"

# rust
# bass source "$HOME/.cargo/env"

fish_add_path /usr/local/sbin

# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# https://direnv.net/docs/hook.html
# direnv hook fish | source

set -gx PATH "$HOME/.local/bin" $PATH
set -gx PATH "$HOME/.local/share/JetBrains/Toolbox/scripts/" $PATH
