# Media playback, codecs, audio, and recording tools
{ pkgs, ... }:

{
  home.packages = [
    pkgs.ani-cli
    pkgs.cava
    pkgs.easyeffects
    pkgs.ffmpeg
    pkgs.gpu-screen-recorder-gtk
    pkgs.mpv
    pkgs.vlc
    pkgs.yt-dlp
  ];
}
