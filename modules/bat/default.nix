{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula"; 
      pager = "less -FR";
    };
  };
  

  home.shellAliases = {
    cat = "bat";
  };
}
