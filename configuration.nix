# Main system configuration - universal settings only
{ pkgs, ... }:

{
  system.stateVersion = "25.11";

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  programs.neovim.defaultEditor = true;

  environment = {
    systemPackages = [
      pkgs.git
      pkgs.wget
      pkgs.gparted
    ];
  };
}
