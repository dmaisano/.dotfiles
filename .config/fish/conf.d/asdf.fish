# if not set -q ASDF_DATA_DIR
#     set -gx ASDF_DATA_DIR "$HOME/.asdf"
# end

# if test -d "$HOME/.asdf"
#     source "$HOME/.asdf/asdf.fish"

#     if test -d "$HOME/.asdf/plugins/golang"
#         source "$HOME/.asdf/plugins/golang/set-env.fish"
#         set -gx ASDF_GOLANG_MOD_VERSION_ENABLED true
#     end
# end

if test -z $ASDF_DATA_DIR
    set _asdf_shims "$HOME/.asdf/shims"
else
    set _asdf_shims "$ASDF_DATA_DIR/shims"
end

# Do not use fish_add_path (added in Fish 3.2) because it
# potentially changes the order of items in PATH
if not contains $_asdf_shims $PATH
    set -gx --prepend PATH $_asdf_shims
end
set --erase _asdf_shims
