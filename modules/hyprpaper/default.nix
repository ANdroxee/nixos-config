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
      # C'est ici que la magie opère : on dit explicitement quelle image va où
      wallpaper = [ 
        "DP-2,/etc/nixos/wallpaper/wallpaper.jpg"      # Pour l'écran 240Hz
        "HDMI-A-1,/etc/nixos/wallpaper/wallpaper.jpg"  # Pour l'écran secondaire
      ];
    };
  };
}