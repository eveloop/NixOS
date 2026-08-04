# Software development and Nix toolchain packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.gcc
    pkgs.kubectl
    pkgs.nil # Nix LSP
    pkgs.nix-output-monitor
    pkgs.nix-search-cli
    pkgs.sourcegit
    pkgs.tokei
    pkgs.vscodium-fhs
  ];
}
