# if test $IS_WSL -eq 1
#     # ensure user has sudo privledges
#     # https://www.simplehelp.net/2009/05/27/how-to-stop-ubuntu-from-asking-for-your-sudo-password/

#     # https://x410.dev/cookbook/wsl/sharing-dbus-among-wsl2-consoles/

#     # set DISPLAY variable to the IP automatically assigned to WSL2
#     # set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
#     # Automatically start dbus
#     # sudo /etc/init.d/dbus start &> /dev/null
# end


set -gx OS_TYPE
if test -e /mnt/c/Windows/System32/wsl.exe
    set -gx OS_TYPE wsl2
else if test (uname) = Linux
    set -gx OS_TYPE linux
else if test (uname) = Darwin
    set -gx OS_TYPE macos
end


if test $OS_TYPE = wsl2 -o $OS_TYPE = linux
    if lsb_release -i | grep -q -E "Ubuntu|Pop"
        set -gx LINUX_DISTRO ubuntu
    else if test -f /etc/arch-release
        set -gx LINUX_DISTRO arch
    end
end


# WSL 2 X-11 forwarding (tl;dr) WSLg has ugly window decorations and janky resizing
# ? Reference - https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj
if test $OS_TYPE = wsl2
    # assume that VcXsrv is running on Windows
    set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
    set -gx LIBGL_ALWAYS_INDIRECT 1
end

if test $OS_TYPE = macos
    # ? source homebrew
    if test -d /opt/homebrew
        fish_add_path /opt/homebrew/bin
    end

    if test -d /usr/local/bin
        fish_add_path PATH /usr/local/bin
    end

    if test -d ~/.ssh
        if not pgrep -u (whoami) ssh-agent >/dev/null
            eval (ssh-agent -c)
        end

        /usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_ed25519 >/dev/null 2>&1
        /usr/bin/ssh-add --apple-use-keychain ~/.ssh/id_ed25519_personal >/dev/null 2>&1
    end

    # fish_add_path /usr/local/sbin
end
