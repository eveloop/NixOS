# Gaming-related packages and tools
{ pkgs, inputs, ... }:

{
  home.packages = [
    pkgs.archipelago
    pkgs.deadlock-mod-manager
    pkgs.ferium
    pkgs.mangohud
    pkgs.poptracker
    pkgs.protonplus
    pkgs.protontricks
    pkgs.r2modman
    pkgs.runelite
    pkgs.samrewritten
    pkgs.winetricks
    pkgs.wineWow64Packages.staging
    (import inputs.creamlinux-installer { inherit pkgs; })
  ];
}
