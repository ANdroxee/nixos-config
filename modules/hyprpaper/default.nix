{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ 
        "/etc/nixos/wallpaper/wallpaper.jpg" 
      ];
      
      wallpaper = [ 
        ",/etc/nixos/wallpaper/wallpaper.jpg"
      ];
    };
  };
}