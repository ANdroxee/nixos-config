{ config, pkgs, ... }:

{
  programs.hyprlock = {
    enable = true;
    
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      background = [
        {
          monitor = "";
          path = "/etc/nixos/wallpaper/wallpaper.jpg";
          blur_passes = 0.5;
        }
      ];

      label = [
        # TIME
        {
          monitor = "";
          text = ''cmd[update:30000] echo "$(date +"%I:%M %p")"'';
          font_size = 90;
          font_family = "JetBrains Mono Regular";
          position = "0, 200";
          halign = "center";
          valign = "center";
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
        }
      ];
  

      input-field = [
        {
          monitor = "";
          size = "400, 60";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.2;
          dots_center = true;
          fade_on_empty = false;
          placeholder_text = ''<i>󰌾 Logged in as $USER</i>'';
          hide_input = false;
          position = "0, -200";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}