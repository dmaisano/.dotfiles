# pnpm
set -gx PNPM_HOME "$HOME/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    fish_add_path $PNPM_HOME
end
# pnpm end
