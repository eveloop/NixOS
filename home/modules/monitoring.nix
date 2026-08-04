# System monitoring packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.btop
    pkgs.ctop
    pkgs.hyperfine
    pkgs.iotop
    pkgs.lm_sensors
    pkgs.lsof
    pkgs.ltrace
    pkgs.pciutils
    pkgs.strace
    pkgs.sysstat
    pkgs.usbutils
  ];
}
