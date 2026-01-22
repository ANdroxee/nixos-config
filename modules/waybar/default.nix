{ config, lib, pkgs, ... }:

{
  options.waybar = {
    isLaptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether this is a laptop configuration";
    };
  };

  config = {
    programs.waybar = {
      enable = true;
      systemd.enable = true;

      settings = [{
        layer = "top";
        position = "top";
        margin-top = 5;
        margin-left = 10;
        margin-right = 10;
        
        modules-left = [ "custom/launcher" "hyprland/workspaces" "cpu" "memory" ];
        modules-center = [ "clock" ];
        # AJOUT DU BLUETOOTH ICI (entre pulseaudio et network)
        modules-right = [ "tray" "pulseaudio" "bluetooth" "network" "battery" "custom/power" ];

        # --- MODULES ---
        
        "custom/launcher" = {
          format = "";
          on-click = "rofi -show drun";
          tooltip = false;
        };

        "hyprland/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
          on-click = "activate";
          format = "{name}";
        };

        "tray" = {
          icon-size = 18;
          spacing = 10;
        };

        "cpu" = {
          interval = 10;
          format = " {usage}%";
          on-click = "kitty -e btop";
        };

        "memory" = {
          interval = 30;
          format = " {percentage}%";
          on-click = "kitty -e btop";
        };

        "clock" = {
          format = "{:%H:%M}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          format-alt = "{:%Y-%m-%d}";
        };

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "";
          format-icons = {
            default = ["" "" ""];
          };
          on-click = "pavucontrol";
        };

        # CONFIGURATION BLUETOOTH
        "bluetooth" = {
          format = " {status}";
          format-connected = " {device_alias}";
          format-connected-battery = " {device_alias} {device_battery_percentage}%";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
          tooltip-format-connected = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
          on-click = "blueman-manager";
        };

        "network" = {
          format-wifi = " {signalStrength}%";
          format-ethernet = "󰈀";
          tooltip-format = "{essid} - {ifname} via {gwaddr}";
          format-disconnected = "";
          on-click = "kitty -e nmtui";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";
          format-icons = ["" "" "" "" ""];
        };
        
        "custom/power" = {
          format = "⏻";
          tooltip = false;
          on-click = "wlogout";
        };
      }];

      style = ''
        /* PALETTE CATPPUCCIN MOCHA */
        @define-color base   #1e1e2e;
        @define-color mantle #181825;
        @define-color crust  #11111b;
        @define-color text     #cdd6f4;
        @define-color subtext0 #a6adc8;
        @define-color subtext1 #bac2de;
        @define-color surface0 #313244;
        @define-color surface1 #45475a;
        @define-color surface2 #585b70;
        @define-color overlay0 #6c7086;
        @define-color overlay1 #7f849c;
        @define-color overlay2 #9399b2;
        @define-color blue      #89b4fa;
        @define-color lavender  #b4befe;
        @define-color sapphire  #74c7ec;
        @define-color sky       #89dceb;
        @define-color teal      #94e2d5;
        @define-color green     #a6e3a1;
        @define-color yellow    #f9e2af;
        @define-color peach     #fab387;
        @define-color maroon    #eba0ac;
        @define-color red       #f38ba8;
        @define-color mauve     #cba6f7;
        @define-color pink      #f5c2e7;
        @define-color flamingo  #f2cdcd;
        @define-color rosewater #f5e0dc;

        * {
          font-family: "JetBrainsMono Nerd Font", Roboto, Helvetica, Arial, sans-serif;
          font-size: 13px;
          font-weight: bold;
          min-height: 0;
        }

        window#waybar {
          background-color: transparent;
        }

        #workspaces,
        #custom-launcher,
        #cpu,
        #memory,
        #clock,
        #pulseaudio,
        #bluetooth,   /* AJOUT DU BLUETOOTH DANS LA LISTE CSS */
        #network,
        #battery,
        #custom-power,
        #tray {
          background-color: @base;
          color: @text;
          border-radius: 15px;
          padding: 5px 15px;
          margin-top: 5px;
          margin-bottom: 5px;
          margin-left: 6px; 
          margin-right: 6px;
          box-shadow: 2px 2px 2px 1px rgba(0,0,0,0.2);
          border: 1px solid @surface1;
        }

        #custom-launcher {
          color: @blue;
          padding-right: 20px;
          font-size: 16px;
        }

        #workspaces button {
          color: @overlay1;
          padding: 0 5px;
        }
        #workspaces button.active {
          color: @blue;
        }
        
        #clock {
          background-color: @surface0;
          color: @blue;
        }

        #cpu { color: @sapphire; }
        #memory { color: @teal; }
        
        #pulseaudio { color: @mauve; }
        
        /* Couleur du Bluetooth */
        #bluetooth { color: @blue; }
        
        #network { color: @lavender; }
        #network.disconnected { color: @red; }
        
        #battery { color: @green; margin-left: 10px; }
        #battery.charging { color: @yellow; }
        #battery.critical { color: @red; }

        #custom-power {
          background-color: @red;
          color: @base;
        }
        
        #tray { padding: 5px 10px; }
      '';
    };

    # ---------------------------------------------------
    # CONFIGURATION WLOGOUT
    # ---------------------------------------------------
    programs.wlogout = {
      enable = true;
      layout = [
        { label = "lock"; action = "hyprlock"; text = "Verrouiller"; keybind = "l"; }
        { label = "reboot"; action = "systemctl reboot"; text = "Redémarrer"; keybind = "r"; }
        { label = "shutdown"; action = "systemctl poweroff"; text = "Éteindre"; keybind = "s"; }
        { label = "logout"; action = "hyprctl dispatch exit 0"; text = "Déconnexion"; keybind = "e"; }
        { label = "suspend"; action = "systemctl suspend"; text = "Veille"; keybind = "u"; }
      ];
      style = ''
        * { background-image: none; box-shadow: none; }
        window { background-color: rgba(30, 30, 46, 0.85); }
        button {
          border-radius: 15px;
          border: 2px solid #313244;
          background-color: #1e1e2e;
          color: #cdd6f4;
          margin: 10px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }
        button:hover {
          background-color: #89b4fa;
          color: #1e1e2e;
          border-color: #89b4fa;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
        }
        #lock { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png")); }
        #logout { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png")); }
        #suspend { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png")); }
        #shutdown { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png")); }
        #reboot { background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png")); }
      '';
    };
  };
}