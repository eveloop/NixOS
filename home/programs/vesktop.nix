# home/programs/vesktop.nix
{ pkgs, ... }:
{
  home.file.".config/systemd/user/app-vesktop@autostart.service.d/override.conf".text = ''
    [Unit]
    After=graphical-session.target

    [Service]
    ExecStartPre=${pkgs.writeShellScript "wait-for-display" ''
      for i in $(seq 1 50); do
        if [ -n "$WAYLAND_DISPLAY" ] && [ -S "''${XDG_RUNTIME_DIR}/''${WAYLAND_DISPLAY}" ]; then
          exit 0
        fi
        if [ -n "$DISPLAY" ] && [ -S "/tmp/.X11-unix/X''${DISPLAY#:}" ]; then
          exit 0
        fi
        sleep 0.2
      done
      exit 1
    ''}
  '';

  xdg.desktopEntries.vesktop = {
    name = "Discord (Vesktop)";
    genericName = "Internet Messenger";
    exec = "vesktop %U";
    icon = "vesktop";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "InstantMessaging"
      "Chat"
    ];
    startupNotify = true;
    settings = {
      StartupWMClass = "vesktop";
    };
  };
}
