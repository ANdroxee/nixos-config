{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "/etc/nixos/wallpaper/wallpaper.jpg" ];
      wallpaper = [ ",/etc/nixos/wallpaper/wallpaper.jpg" ];
      ipc = "off";
      splash = false;
    };
  };
}