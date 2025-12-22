{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
        no_fade_in = false; 
      };

      background = [
        {
          monitor = "";
          # Essaie d'abord avec un chemin sûr dans ton home pour tester
          # path = "/home/ton_user/wallpaper.jpg"; 
          path = "/etc/nixos/wallpaper/wallpaper.jpg"; 
          
          # COULEUR DE SECOURS : Si l'image foire, tu auras du gris foncé au lieu du noir complet
          color = "rgba(25, 20, 20, 1.0)";

          # CORRECTION ICI : Doit être un entier (1, 2, 3...) pas 0.5
          blur_passes = 2; 
          blur_size = 7;
        }
      ];

      label = [
        # TIME
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%H:%M")"''; # Simplifié pour test
          font_size = 90;
          font_family = "JetBrains Mono Regular";
          position = "0, 200";
          halign = "center";
          valign = "center";
          color = "rgba(200, 200, 200, 1.0)"; # Ajout explicite de couleur
        }
        # DATE
        {
          monitor = "";
          text = ''cmd[update:43200000] echo "$(date +"%A, %d %B %Y")"'';
          font_size = 25;
          font_family = "JetBrains Mono Regular";
          position = "0, 130";
          halign = "center";
          valign = "center";
          color = "rgba(200, 200, 200, 1.0)";
        }
      ];
  
      input-field = [
        {
          monitor = "";
          size = "400, 60";
          outline_thickness = 3;
          dots_size = 0.33; # Ajusté
          dots_spacing = 0.15;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = ''<i>󰌾 Logged in as $USER</i>'';
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
          
          # Assurons-nous que les couleurs sont visibles
          outer_color = "rgb(151515)";
          inner_color = "rgb(200, 200, 200)";
          font_color = "rgb(10, 10, 10)";
        }
      ];
    };
  };
}