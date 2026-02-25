{ config, pkgs, lib, osConfig, ... }:

let
  hostname = osConfig.networking.hostName;
  wallpaperPath = "${./wallpaper/wallpaper.jpg}";
  
  useSwaybg = hostname == "arasaka";
  
  wallpaperMirror = "/home/androxe/.config/wallpaper.jpg";
in

{
  home.packages = with pkgs; [
    (if useSwaybg then swaybg else hyprpaper)
  ];

  services.hyprpaper = lib.mkIf (!useSwaybg) {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ wallpaperMirror ];
      wallpaper = [
        {
          monitor = "eDP-1";
          path = wallpaperMirror;
        }
      ];
    };
  };

  home.file.".config/wallpaper.jpg" = {
    source = wallpaperPath;
  };
}
