# Git configuration
{
  config,
  pkgs,
  ...
}:

{
  home.packages = [
    pkgs.delta
  ];

  programs.git = {
    enable = true;
    includes = [ { path = "${config.home.homeDirectory}/.config/git/secrets.inc"; } ];
    settings = {
      core.editor = "nvim";
      core.pager = "delta";
      delta.navigate = true;
      interactive.diffFilter = "delta --color-only";
      merge.conflictStyle = "zdiff3";
    };
  };
}
