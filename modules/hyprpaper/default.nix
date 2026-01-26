{ config, pkgs, ... }:

{
  home.packages = [ pkgs.hyprpaper ];

  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      
      preload = [ "${./wallpaper/wallpaper.jpg}" ];
      wallpaper = [ "eDP-1,${./wallpaper/wallpaper.jpg}" ];
    };
  };
}