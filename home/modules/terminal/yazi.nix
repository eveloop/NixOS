# Yazi - terminal-based file manager
_:

{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";
    settings = {
      mgr = {
        show_hidden = true;
        sort_by = "mtime";
        sort_reverse = true;
      };
      opener = {
        edit = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
        text = [
          {
            run = "nvim \"$@\"";
            block = true;
          }
        ];
      };
    };
  };
}
