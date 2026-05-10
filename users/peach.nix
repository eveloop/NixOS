{ pkgs, ... }:
{
  users.users.peach = {
    isNormalUser = true;
    description = "Peach";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  # Home Manager configuration
  home-manager.users.peach =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      imports = [
        ../home/default.nix
      ];

      home = {
        username = "peach";
        homeDirectory = "/home/peach";
        stateVersion = "25.11";
        sessionVariables.EDITOR = "nvim";
      };

      sops.age.keyFile = "/home/peach/.config/sops/age/keys.txt";
      sops.secrets.git_email = {
        sopsFile = ../secrets/peach.yaml;
      };
      sops.secrets.git_name = {
        sopsFile = ../secrets/peach.yaml;
      };
      sops.templates."git-secrets" = {
        path = "${config.home.homeDirectory}/.config/git/secrets.inc";
        mode = "0600";
        content = ''
          [user]
            email = ${config.sops.placeholder.git_email}
            name = ${config.sops.placeholder.git_name}
        '';
      };
    };
}
