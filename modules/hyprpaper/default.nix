{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ 
        "${./wallpaper/wallpaper.jpg}"
      ];
      
      wallpaper = [ 
        "${./wallpaper/wallpaper.jpg}"
      ];
    };
  };
}