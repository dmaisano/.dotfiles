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
  set -gx OS_TYPE "wsl2"
else if test (uname) = "Linux"
  set -gx OS_TYPE "linux"
else if test (uname) = "Darwin"
  set -gx OS_TYPE "macos"
end

# WSL 2 X-11 forwarding (tl;dr) WSLg has ugly window decorations and janky resizing
# ? Reference - https://aalonso.dev/blog/how-to-use-gui-apps-in-wsl2-forwarding-x-server-cdj
if test $OS_TYPE = "wsl2"
  # assume that VcXsrv is running on Windows
  set -gx DISPLAY (cat /etc/resolv.conf | grep nameserver | awk '{print $2; exit;}'):0.0
  set -gx LIBGL_ALWAYS_INDIRECT 1
end
