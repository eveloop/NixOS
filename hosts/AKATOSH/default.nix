let
  hostName = "AKATOSH";
  architecture = "x86_64-linux";
in
{
  meta = {
    inherit hostName architecture;
  };

  module =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        ./hardware-configuration.nix
        ./wifi.nix
      ];

      boot = {
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
        kernel.sysctl."fs.inotify.max_user_watches" = 524288;
      };

      hardware = {
        enableRedistributableFirmware = true;
        xone.enable = true;

        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };

        graphics = {
          enable = true;
        };
      };

      i18n.defaultLocale = "en_US.UTF-8";

      networking = {
        firewall = {
          enable = true;
          interfaces."wlp4s0" = {
            allowedTCPPorts = [
              8096
              8920
            ]; # Jellyfin
            allowedTCPPortRanges = [
              {
                from = 1714;
                to = 1764;
              }
            ]; # KDE Connect
            allowedUDPPorts = [ 7359 ]; # Jellyfin
            allowedUDPPortRanges = [
              {
                from = 1714;
                to = 1764;
              }
            ]; # KDE Connect
          };
        };
        hostName = hostName;
        networkmanager.enable = true;
        nftables.enable = true;
      };

      programs = {
        fish.enable = true;
        gpu-screen-recorder.enable = true;
        gamescope.enable = true;
        gamemode.enable = true;
        kdeconnect.enable = true;
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = true;
          localNetworkGameTransfers.openFirewall = true;
          gamescopeSession.enable = true;
        };
      };

      services = {
        blueman.enable = true;
        desktopManager.plasma6.enable = true;
        displayManager.sddm.enable = true;
        flatpak.enable = true;

        jellyfin = {
          enable = true;
          dataDir = "/var/lib/jellyfin";
        };

        mullvad-vpn = {
          enable = true;
          package = pkgs.mullvad-vpn;
        };

        openssh = {
          enable = true;
          settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
            ListenAddress = "127.0.0.1";
            X11Forwarding = false;
            AllowAgentForwarding = false;
            MaxAuthTries = 3;
            ClientAliveInterval = 300;
          };
        };

        pcscd.enable = true;

        pipewire = {
          enable = true;
          alsa = {
            enable = true;
            support32Bit = true;
          };
          # Helps resolve audio output crackling when using heavier audio effects in Easy Effects
          extraConfig.pipewire."custom-adjustments" = {
            "context.properties" = {
              "link.max-buffers" = 64;
              "default.clock.rate" = 48000;
              "default.clock.quantum" = 1024;
              "default.clock.min-quantum" = 1024;
              "default.clock.max-quantum" = 2048;
            };
          };
        };
        xserver = {
          xkb.layout = "us,lt";
          xkb.options = "grp:win_space_toggle";
        };
      };

      security = {
        sudo = {
          wheelNeedsPassword = true;
          execWheelOnly = true;
        };
        polkit.enable = true;
        rtkit.enable = true;
      };

      sops.age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

      time = {
        timeZone = "Europe/Vilnius";
        hardwareClockInLocalTime = true;
      };

      users.defaultUserShell = pkgs.fish;

      virtualisation.docker.rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };
}
