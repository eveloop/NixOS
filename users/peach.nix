{ profiles }:
{ pkgs, ... }:
{
  users.users.peach = {
    isNormalUser = true;
    description = "Peach";
    extraGroups = [
      "gamemode"
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.fish;
  };

  home-manager.users.peach = { config, ... }: {
    imports = map (profile: ../home/profiles/${profile}.nix) profiles;

    home = {
      username = "peach";
      homeDirectory = "/home/peach";
      stateVersion = "25.11";
      sessionVariables.EDITOR = "nvim";
    };

    sops = {
      age.keyFile = "/home/peach/.config/sops/age/keys.txt";
      secrets.git_email.sopsFile = ../secrets/peach.yaml;
      secrets.git_name.sopsFile = ../secrets/peach.yaml;
      templates."git-secrets" = {
        path = "${config.home.homeDirectory}/.config/git/secrets.inc";
        mode = "0600";
        content = ''
          [user]
            email = ${config.sops.placeholder.git_email}
            name = ${config.sops.placeholder.git_name}
        '';
      };
    };
  };
}
