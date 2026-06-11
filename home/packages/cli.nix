# CLI utility packages
{ pkgs, ... }:

{
  home.packages = with pkgs; [
    bat
    dust
    eza
    fastfetch
    fd
    file
    fzf
    gitui
    glow
    jq
    neovim
    nix-output-monitor
    nix-search-cli
    presenterm
    rclone
    ripgrep
    ripgrep-all
    tree
    which
    yq-go
    yt-dlp
    zoxide
  ];
}
