if not set -q ASDF_DATA_DIR
    set -gx ASDF_DATA_DIR "$HOME/.asdf"
end

if test -d "$HOME/.asdf"
    source "$HOME/.asdf/asdf.fish"

    if test -d "$HOME/.asdf/plugins/golang"
        source "$HOME/.asdf/plugins/golang/set-env.fish"
        set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true
    end
end
