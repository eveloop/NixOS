# Gaming-related packages and tools
{ pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    archipelago
    deadlock-mod-manager
    ferium
    mangohud
    poptracker
    protonplus
    protontricks
    r2modman
    runelite
    samrewritten
    winetricks
    wineWow64Packages.staging
    (import inputs.creamlinux-installer { inherit pkgs; })
  ];
}
