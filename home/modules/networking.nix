# Networking diagnostic packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.aria2
    pkgs.dnsutils
    pkgs.ethtool
    pkgs.iftop
    pkgs.iperf3
    pkgs.ldns
    pkgs.nmap
    pkgs.rclone
    pkgs.socat
    pkgs.xh
  ];
}
