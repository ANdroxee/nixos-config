{ pkgs, ... }:

{
  programs.btop = {
    enable = true;
    
    settings = {
      color_theme = "default";  
      theme_background = false; 
      truecolor = true;
      presets = "cpu:1:default,proc:0:default,mem:0:default,net:0:default,cpu:0:default,proc:1:default,mem:1:default,net:1:default,cpu:0:default,proc:0:default,mem:0:default,net:0:default";
      vim_keys = true;          
      update_ms = 500;          
      rounded_corners = true;
    };
  };
}
