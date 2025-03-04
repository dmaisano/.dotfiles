if test -d "$HOME/.asdf"
    source "$HOME/.asdf/asdf.fish"

    if test -d "$HOME/.asdf/plugins/golang"
        source "$HOME/.asdf/plugins/golang/set-env.fish"
        fish_add_path $GOBIN
        set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true
    end
end
