# Graphical desktop applications (non-media)
{ pkgs, ... }:

{
  home.packages = [
    pkgs.librewolf
    pkgs.planify
    pkgs.sparrow
  ];
}
