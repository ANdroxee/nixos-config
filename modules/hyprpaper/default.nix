{ config, pkgs, ... }:

{
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = "on";
      splash = false;
      preload = [ 
        "/home/androxe/Images/wallpaper.jpg" 
      ];
      
      # LA SOLUTION UNIVERSELLE :
      # La virgule au début signifie "Applique sur tous les moniteurs trouvés"
      # Plus besoin de se soucier si c'est DP-1, DP-2 ou HDMI-A-1 !
      wallpaper = [ 
        ",/home/androxe/Images/wallpaper.jpg"
      ];
    };
  };
}