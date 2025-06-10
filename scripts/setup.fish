#!/usr/bin/env fish

# NOTE: add the fish shell PPA if running on Ubuntu
# sudo apt-add-repository ppa:fish-shell/release-3

set REPO_ROOT_DIR (realpath (dirname (dirname (status filename))))
set SCRIPT_DIR (realpath (dirname (status filename)))

function setup_fnm
    set -l BASE_FILE_NAME fnm_install
    echo -e "⏳ Installing fnm -- 🚀 Fast and simple Node.js version manager, built in Rust\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

    curl -fsSL https://fnm.vercel.app/install >$SCRIPT_DIR/$BASE_FILE_NAME.sh
    bash $SCRIPT_DIR/$BASE_FILE_NAME.sh --install-dir "$HOME/.fnm" >"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt" 2>&1 &
    wait

    # ? handle any errors
    set -l matches (string match -r -i -g -- "(unzip)\.\.\. missing" (cat "$SCRIPT_DIR/$BASE_FILE_NAME"_output.txt))
    if test (count $matches) -gt 0
        for match in $matches
            echo "❌ Error installing fnm: missing dependency '$match'"
        end
    end
end

function setup_git
    read -l -P "🐙 Enter git username: " username
    read -l -P "📧 Enter git email addreess: " email

    git config --global user.name $username
    git config --global user.email $email
    git config --global credential.helper 'store --file ~/.my-credentials'
    git config --global core.editor "code --wait"
    git config --global init.defaultBranch main
    git config --global pull.rebase true
end

function setup_git_hooks
    mkdir -p $REPO_ROOT_DIR/.git/hooks
    ln -sf $REPO_ROOT_DIR/git-hooks/pre-commit $REPO_ROOT_DIR/.git/hooks/pre-commit
    chmod +x $REPO_ROOT_DIR/.git/hooks/pre-commit
    echo "🪝  Git hooks setup complete"
end

function setup_pyenv
    curl -fsSL https://pyenv.run | bash
end

function setup_oh_my_fish
    set -l BASE_FILE_NAME omf_install
    set OMF_PATH "$HOME/.local/share/omf"
    echo -e "⏳ Installing oh-my-fish -- 🐠 The Fish Shell Framework\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

    curl -fsSL https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install >"$SCRIPT_DIR/$BASE_FILE_NAME"".fish"
    fish "$SCRIPT_DIR/$BASE_FILE_NAME"".fish" --noninteractive --path=$OMF_PATH --config=~/.config/omf >omf_install_output.txt 2>&1 &
    wait

    echo "🧠 Don't forget to run $(set_color brcyan)'omf install'$(set_color normal) later! Ensure $(set_color brcyan)'~/.config/omf/bundle'$(set_color normal) has been copied over."
    wait
end

function setup_starship
    set -l BASE_FILE_NAME starship_install
    echo "⏳ Installing starship -- 💫 The minimal, blazing-fast, and infinitely customizable prompt for any shell\nCheck \"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt for more details."

    curl -fsSL https://starship.rs/install.sh >$SCRIPT_DIR/$BASE_FILE_NAME.sh
    sh $SCRIPT_DIR/$BASE_FILE_NAME.sh -y >"$SCRIPT_DIR/$BASE_FILE_NAME""_output.txt" 2>&1 &
    wait
end

function setup_symlinks
    if not type -q stow
        echo "❌ 'stow' command is not installed. Exiting..."
        return
    end

    stow --adopt .
    read -l -P "Run $(set_color brcyan)'git restore .'$(set_color normal)? $(set_color bryellow)(y/N)$(set_color normal): " confirmation
    if test (string trim -c " " -- (string lower -- $confirmation)) = y
        git restore .
    end

    # stow -n -v * # test run

    setup_git_hooks
end

function reset_dotfiles
    set folder_names ~/{.oh-my-zsh, .zshrc} ~/.local/share/{fish, omf}
    for entry in (ls $REPO_ROOT_DIR/.config)
        set folder_names $folder_names ~/.config/$entry
    end

    set friendly_folder_names
    for folder_name in $folder_names
        set friendly_folder_names $friendly_folder_names (string replace -r "$HOME" "~" $folder_name)
    end

    set friendly_folder_names (printf "%s\n" $friendly_folder_names | sort)
    set friendly_folder_names (string join ", " $friendly_folder_names)
    echo -e "⛔ Hold on pardner! 🤠 The following folders will be deleted:\n$(set_color brgreen)$friendly_folder_names$(set_color normal)"
    read -l -P "Do you want to continue? $(set_color bryellow)(y/N)$(set_color normal): " confirmation

    if test (string trim -c " " -- (string lower -- $confirmation)) = y
        echo "📁 Deleting folders..."
        rm -rf $folder_names
    else
        echo "👍 No changes made!"
    end
end

function main
    # ? Intention is to run one function at a time. Restarting the shell maybe be required as needed
    if test (count $argv) -eq 0
        echo "Missings arguments. Please specify at least one of the following options: fnm, git, hooks, omf, pyenv, starship, symlinks, $(set_color bryellow)reset$(set_color normal)."
        exit 1
    end

    # TODO - better argparse logic with flag options

    if contains fnm $argv
        setup_fnm
    else if contains asdf $argv
        setup_asdf
    else if contains git $argv
        setup_git
    else if contains hooks $argv
        setup_git_hooks
    else if contains omf $argv
        setup_oh_my_fish
    else if contains pyenv $argv
        setup_pyenv
    else if contains starship $argv
        setup_starship
    else if contains symlinks $argv
        setup_symlinks
    else if contains reset $argv
        reset_dotfiles
    end

    echo "Please remember to start a new shell instance when done! 🐚"
end

main $argv
