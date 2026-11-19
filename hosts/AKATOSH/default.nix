{ pkgs, lib, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./wifi.nix
  ];

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 20;
        bootCounting.enable = true;
        editor = false;
      };
      efi.canTouchEfiVariables = true;
    };
    kernel.sysctl = {
      # Kernel hardening baseline
      "kernel.dmesg_restrict" = 1;
      "kernel.kptr_restrict" = 2;
      "net.core.bpf_jit_harden" = 2;
      "kernel.unprivileged_bpf_disabled" = 1;
      "fs.protected_fifos" = 2;
      "fs.protected_regular" = 2;
    };
    kernelParams = [ "amd_pstate=active" ];
    # TRIM through dm-crypt (declared here via module merging; device paths
    # stay in hardware-configuration.nix).
    initrd.luks.devices = {
      root = {
        allowDiscards = true;
        bypassWorkqueues = true;
      };
      small_ssd = {
        allowDiscards = true;
        bypassWorkqueues = true;
      };
      swap.allowDiscards = true;
    };
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
          8096 # Jellyfin
        ];
        allowedUDPPorts = [
          7359 # Jellyfin
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
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };

  services = {
    blueman.enable = true;
    desktopManager.plasma6.enable = true;
    displayManager.sddm.enable = true;
    flatpak.enable = true;

    fstrim.enable = true;

    jellyfin = {
      enable = true;
    };

    mullvad-vpn = {
      enable = true;
      gui.enable = true;
      enableExcludeWrapper = false;
      enableEarlyBootBlocking = true;
    };

    openssh = {
      enable = true;
      openFirewall = false;
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        ListenAddress = "127.0.0.1";
        X11Forwarding = false;
        AllowAgentForwarding = false;
        MaxAuthTries = 3;
        ClientAliveInterval = 300;
      };
    };

    pcscd.enable = true;

    # SMART health monitoring.
    smartd.enable = true;

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
    # This conflicts with hibernation, review if considering to enable later.
    protectKernelImage = true;
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
