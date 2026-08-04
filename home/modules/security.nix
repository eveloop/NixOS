# Security tool packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.age
    pkgs.cryptsetup
    pkgs.gnupg
    pkgs.openssl
    pkgs.sops
    pkgs.ssh-to-age
    pkgs.veracrypt
    pkgs.yubioath-flutter
  ];
}
