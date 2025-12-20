{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true; 
    git = true;      
    icons = "auto";  
  };
  
  home.shellAliases = {
    ls = "eza";
    ll = "eza -l --icons --git -a";
    lt = "eza --tree --level=2 --long --icons --git";
  };
}
