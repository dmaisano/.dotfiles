set -gx PNPM_HOME "$HOME/.local/share/pnpm"
fish_add_path $PNPM_HOME


set -gx BUN_INSTALL "$HOME/.bun"
fish_add_path $BUN_INSTALL/bin
