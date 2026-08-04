# CLI utility packages
{ pkgs, ... }:

{
  home.packages = [
    pkgs.bat
    pkgs.dust
    pkgs.eza
    pkgs.fastfetch
    pkgs.fd
    pkgs.file
    pkgs.fzf
    pkgs.gitui
    pkgs.glow
    pkgs.jq
    pkgs.neovim
    pkgs.presenterm
    pkgs.ripgrep
    pkgs.ripgrep-all
    pkgs.tree
    pkgs.which
    pkgs.yq-go
    pkgs.zoxide
  ];
}
