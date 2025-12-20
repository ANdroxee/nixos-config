{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true; 
    
    theme = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };
    };
  };

  home.shellAliases = {
    r = "yazi"; 
  };
}
