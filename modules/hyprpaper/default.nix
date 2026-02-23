{ config, pkgs, lib, osConfig, ... }:

let
  hostname = osConfig.networking.hostName;
  wallpaperPath = "${./wallpaper/wallpaper.jpg}";
  
  # Pour arasaka (NVIDIA), utiliser swaybg qui est plus compatible
  # Pour androxe (portable), utiliser hyprpaper
  useSwaybg = hostname == "arasaka";
  
  # Define stable path for config use
  wallpaperMirror = "/home/androxe/.config/wallpaper.jpg";
in

{
  home.packages = with pkgs; [
    (if useSwaybg then swaybg else hyprpaper)
  ];

  # Configuration pour hyprpaper (androxe uniquement)
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

  # Configuration pour swaybg (arasaka uniquement)
  # Swaybg sera lancé via exec-once dans autostart.nix
  
  # Copier le wallpaper dans le home directory pour un accès facile
  home.file.".config/wallpaper.jpg" = {
    source = wallpaperPath;
  };
}
