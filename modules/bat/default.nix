{ pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula"; # Tu peux choisir "TwoDark", "Nord", etc.
      pager = "less -FR";
    };
  };
  
  # Alias pour utiliser bat à la place de cat
  home.shellAliases = {
    cat = "bat";
  };
}
