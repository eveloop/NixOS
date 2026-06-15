{ pkgs, ... }:

{
  home.packages = with pkgs; [
    maple-mono.NF
  ];

  programs.wezterm = {
    enable = true;
    extraConfig = ''
      local wezterm = require("wezterm")

      return {
        font = wezterm.font("Maple Mono NF"),
        font_size = 12.0,
        color_scheme = "Dracula",
      }
    '';
  };
}
