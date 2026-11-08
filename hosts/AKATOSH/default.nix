{ pkgs, lib, ... }:
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
    kernelParams = [ "amd_pstate=active" ];
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
      extraPackages32 = [ pkgs.driversi686Linux.mesa ];
    };

    amdgpu.overdrive.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";

  networking = {
    nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];
    networkmanager = {
      dns = lib.mkForce "none";
      wifi.powersave = false;
      enable = true;
    };
    firewall = {
      enable = true;
      interfaces."wlp4s0" = {
        allowedTCPPorts = [
          8096
          8920
          27015 # Steam SRCDS Rcon port
          27036 # Steam Remote Play / peer discovery
          27037 # Steam Remote Play
          27040 # Steam local network game transfers (data)
        ];
        allowedUDPPorts = [
          7359 # Jellyfin
          10400
          10401 # Steam Remote Play
          27015 # Steam SRCDS gameplay traffic
          27036 # Steam Remote Play peer discovery
        ];
        allowedUDPPortRanges = [
          {
            from = 1714;
            to = 1764;
          } # KDE Connect
          {
            from = 27031;
            to = 27035;
          } # Steam Remote Play
        ];
      };
    };
    hostName = "AKATOSH";
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
      gui.enable = true;
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

    resolved = {
      enable = true;
      settings.Resolve = {
        DNSOverTLS = "yes";
        FallbackDNS = [
          "1.1.1.1"
          "1.0.0.1"
        ];
      };
    };

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
}
