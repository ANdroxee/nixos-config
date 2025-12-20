{ pkgs, ... }:

{
  programs.lazygit = {
    enable = true;
    
    settings = {
      gui.theme = {
        lightTheme = false;
        activeBorderColor = [ "#f6c177" "bold" ]; 
        inactiveBorderColor = [ "#a0a8b7" ];
        optionsTextColor = [ "#9ccfd8" ]; 
        selectedLineBgColor = [ "#26233a" ]; 
        selectedRangeBgColor = [ "#26233a" ];
      };
    };
  };
  
  home.shellAliases = {
    lg = "lazygit";
  };
}
