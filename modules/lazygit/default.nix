{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    
    settings = {
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "#f6c177" "bold" ]; # Orange Stray
        inactiveBorderColor = [ "#a0a8b7" ];
        optionsTextColor = [ "#9ccfd8" ]; # Bleu cyan
        selectedLineBgColor = [ "#26233a" ]; # Fond sombre sélectionné
        selectedRangeBgColor = [ "#26233a" ];
      };
    };
  };
  
  # Alias : tape "lg" pour ouvrir
  home.shellAliases = {
    lg = "lazygit";
  };
}
