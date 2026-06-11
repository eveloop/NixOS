# Fish - Friendly Interactive SHell
{ pkgs, ... }:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      zoxide init fish | source
    '';

    plugins = [
      # Auto-pair brackets, quotes, etc.
      {
        name = "autopair";
        src = pkgs.fishPlugins.autopair.src;
      }
      # Done notification when long commands finish
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
    ];

    shellAliases = {
      # Eza
      ls = "eza --icons";
      ll = "eza -l --icons";
      la = "eza -la --icons";

      # Bat
      cat = "bat";

      # Git
      g = "git";
      ga = "git add";
      gc = "git commit";
      gcb = "git checkout -b";
      gcm = "git commit -m";
      gco = "git checkout";
      gd = "git diff";
      gpull = "git pull";
      gpush = "git push";
      gst = "git status";

      # Docker
      d = "docker";
      dc = "docker-compose";
      dex = "docker exec -it";
      di = "docker images";
      dpa = "docker ps -a";
      dps = "docker ps";

      # Other
      cd = "z";
      du = "dust";
      find = "fd";
      grep = "rg";

      # Nix
      nixclean = "nix-collect-garbage -d && sudo nix-collect-garbage -d";
      nixfmt = "sudo nix fmt .";
      nixshell = "nix-shell -p";
      nixrs = "sudo nixos-rebuild switch";
      ns = "nix-search";
    };

    # Custom Fish functions
    functions = {
      # Docker cleanup
      dclean = ''
        docker container prune -f
        docker image prune -f
        docker volume prune -f
      '';

      # Access Docker container shell
      dsh = ''
        docker exec -it $argv[1] /bin/bash 2>/dev/null || docker exec -it $argv[1] /bin/sh
      '';
    };
  };
}
