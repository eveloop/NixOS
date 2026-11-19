# Main system configuration - universal settings only
{ pkgs, ... }:

{
  system.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;
    allowed-users = [
      "root"
      "@wheel"
    ];
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  systemd.tmpfiles.settings."nix-build-logs" = {
    "/nix/var/log/nix/drvs".e.age = "mM:30d";
  };
  programs.neovim.defaultEditor = true;

  environment = {
    systemPackages = [
      pkgs.git
      pkgs.wget
      pkgs.gparted
    ];
  };
}
