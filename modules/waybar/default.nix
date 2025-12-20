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
      
      settings = [
        {
          layer = "top";
          position = "top";
          
          margin-top = 5;
          margin-left = 10;
          margin-right = 10;
          
          modules-left = [
            "custom/launcher"
            "hyprland/workspaces"
            "cpu"
            "memory"
          ];

          modules-center = [ 
            "clock" 
          ];

          modules-right = [
            "pulseaudio"
            "network"
            "bluetooth"
          ] 
          ++ lib.optionals config.waybar.isLaptop [ "backlight" "battery" ] 
          ++ [ "custom/power" ];

          # --- MODULES ---

          "custom/launcher" = {
            format = "";
            on-click = "rofi -show drun";
            tooltip = false;
          };

          "hyprland/workspaces" = {
            format = "{name}";
            on-click = "activate";
            persistent-workspaces = {
              "*" = 5;
            };
          };

          cpu = {
            interval = 10;
            format = " {usage}%";
            max-length = 10;
            on-click = "kitty -e btop";
          };

          memory = {
            interval = 30;
            format = " {percentage}%";
            max-length = 10;
            tooltip = true;
            tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G";
            on-click = "kitty -e btop";
          };

          clock = {
            format = "{:%H:%M}";
            format-alt = "{:%A %d %B}";
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='#9ccfd8'><b>{}</b></span>"; # Bleu
                days = "<span color='#e0def4'><b>{}</b></span>";
                weeks = "<span color='#c4a7e7'><b>W{}</b></span>";
                today = "<span color='#eb6f92'><b><u>{}</u></b></span>";
              };
            };
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            format-muted = "  Muted";
            format-icons = {
              default = ["" "" ""];
            };
            on-click = "pavucontrol";
            scroll-step = 5;
          };

          network = {
            format-wifi = " ";
            format-ethernet = "󰈀 ";
            format-disconnected = " ";
            tooltip-format = "{ifname} via {gwaddr}";
            tooltip-format-wifi = "{essid} ({signalStrength}%)";
            tooltip-format-ethernet = "{ipaddr}/{cidr}";
            on-click = "kitty -e nmtui";
          };

          bluetooth = {
            format = "";
            format-connected = " {device_alias}";
            format-connected-battery = " {device_alias} {device_battery_percentage}%";
            tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected";
            on-click = "blueman-manager";
          };

          backlight = {
            device = "intel_backlight";
            format = "{icon} {percent}%";
            format-icons = ["" "" "" "" "" "" "" "" ""];
          };

          battery = {
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
            format = "⏻ ";
            tooltip = false;
            on-click = "wlogout";
          };
        }
      ];

      # --- STYLE CSS (Thème Bleu Yazi) ---
      style = ''
        * {
          font-family: "Maple Mono", "JetBrainsMono Nerd Font", sans-serif;
          font-size: 12px;
          font-weight: bold;
          min-height: 0;
        }

        window#waybar {
          background-color: transparent;
        }

        /* --- CONTENEURS --- */
        .modules-left, .modules-center, .modules-right {
          background-color: #191724;
          border: 1px solid #1f1d2e;
          padding: 2px 10px;
          border-radius: 15px;
        }

        .modules-center { padding: 2px 15px; }

        /* --- MODULES --- */
        #custom-launcher {
          color: #9ccfd8; /* Bleu */
          font-size: 16px;
          margin-right: 10px;
          padding-right: 10px;
          border-right: 1px solid #26233a;
        }

        #workspaces button { padding: 0 6px; color: #908caa; }
        
        /* Les chiffres actifs deviennent BLEUS */
        #workspaces button.active { color: #9ccfd8; } 
        
        #workspaces button:hover { color: #e0def4; }

        #cpu, #memory { color: #e0def4; padding-left: 8px; }
        
        /* L'heure devient BLEUE */
        #clock { color: #9ccfd8; }

        #pulseaudio { color: #ebbcba; margin-right: 10px; }
        #network { color: #9ccfd8; margin-right: 10px; }
        #bluetooth { color: #c4a7e7; margin-right: 10px; }
        
        /* Luminosité BLEUE */
        #backlight { color: #9ccfd8; margin-right: 10px; }
        
        #battery { color: #a6e3a1; margin-right: 10px; }
        
        /* Batterie faible devient BLEUE (Warning) */
        #battery.warning { color: #9ccfd8; }
        #battery.critical { color: #eb6f92; }

        #custom-power {
          color: #eb6f92;
          margin-left: 5px;
          padding-left: 8px;
          border-left: 1px solid #26233a;
        }

        tooltip {
          background: #191724;
          border: 1px solid #9ccfd8; /* Bordure du tooltip BLEUE */
          border-radius: 8px;
        }
      '';
    };

    # ---------------------------------------------------
    # CONFIGURATION WLOGOUT (Boutons Power)
    # ---------------------------------------------------
    programs.wlogout = {
      enable = true;
      
      layout = [
        {
          label = "lock";
          action = "hyprlock";
          text = "Verrouiller";
          keybind = "l";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Redémarrer";
          keybind = "r";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Éteindre";
          keybind = "s";
        }
        {
          label = "logout";
          action = "hyprctl dispatch exit 0";
          text = "Déconnexion";
          keybind = "e";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Veille";
          keybind = "u";
        }
      ];

      style = ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(25, 23, 36, 0.85);
        }

        button {
          border-radius: 15px;
          border: 2px solid #eb6f92; 
          background-color: #1f1d2e;
          color: #e0def4;
          margin: 10px;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
        }

        /* Au survol, les boutons deviennent BLEUS */
        button:hover {
          background-color: #9ccfd8; 
          color: #191724;
          border-color: #9ccfd8;
          animation: gradient_f 20s ease-in infinite;
          transition: all 0.3s cubic-bezier(.55,0.0,.28,1.682);
        }
        
        #lock {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/lock.png"));
        }

        #logout {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/logout.png"));
        }

        #suspend {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/suspend.png"));
        }

        #shutdown {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png"));
        }

        #reboot {
          background-image: image(url("${pkgs.wlogout}/share/wlogout/icons/reboot.png"));
        }
      '';
    };
  };
}