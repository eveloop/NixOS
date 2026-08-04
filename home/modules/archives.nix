# Archive & compression packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.lzip
    pkgs.p7zip
    pkgs.unrar
    pkgs.xz
    pkgs.zip
    pkgs.zstd
  ];
}
