# Multimedia applications and tools
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    ani-cli
    cava
    easyeffects
    vesktop
    ffmpeg
    gpu-screen-recorder-gtk
    librewolf
    mpv
    planify
    sparrow
    vlc
  ];
}
