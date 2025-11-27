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
          spacing = 0;
          margin-bottom = -10;

          modules-left = [
            "custom/power"
            "hyprland/workspaces"
            "custom/uptime"
            "cpu"
            "memory"
          ];

          modules-center = [ "clock" ];

          modules-right = [
            "custom/pomodoro"
            "bluetooth"
            "network"
            "pulseaudio"
            "backlight"
            "battery"
          ];

          "custom/power" = {
            format = "⏻";
            tooltip = false;
            on-click = "wlogout -p layer-shell";
          };

          "hyprland/workspaces" = {
            format = "{name}: {icon}";
            format-icons = {
              active = "";
              default = "";
            };
          };

          bluetooth = {
            format = "󰂲  Bluetooth";
            format-on = "{icon}  Bluetooth";
            format-off = "{icon}  Désactivé";
            format-connected = "{icon}  {device_alias}";
            format-icons = {
              on = "󰂯";
              off = "󰂲";
              connected = "󰂱";
            };
            on-click = "blueman-manager";
            tooltip = true;
            tooltip-format = "{status}";
            tooltip-format-connected = "Connecté à:\n{device_enumerate}";
            tooltip-format-enumerate-connected = "  {device_alias}";
            max-length = 25;
          };

          "custom/music" = {
            format = "  {}";
            escape = true;
            interval = 5;
            tooltip = false;
            exec = "playerctl metadata --format='{{ artist }} - {{ title }}'";
            on-click = "playerctl play-pause";
            max-length = 50;
          };

          clock = {
            timezone = "Europe/Paris";
            tooltip = false;
            format = "{:%H:%M:%S  -  %A, %d}";
            interval = 1;
          };

          network = {
            format-wifi = "󰤢  {essid}";
            format-ethernet = "󰈀  Ethernet";
            format-disconnected = "󰤠  Déconnecté";
            interval = 5;
            tooltip = true;
            tooltip-format = "Signal: {signalStrength}%\nIP: {ipaddr}\nFréquence: {frequency}MHz";
            on-click = "nm-connection-editor";
            max-length = 25;
          };

          cpu = {
            interval = 1;
            format = " {usage:>2}%";
            tooltip = true;
            tooltip-format = "CPU: {usage}%";
            on-click = "kitty -e htop";
          };

          memory = {
            interval = 10;
            format = " {used:0.1f}G";
            tooltip = true;
            tooltip-format = "RAM: {used:0.1f}G / {total:0.1f}G ({percentage}%)\nSwap: {swapUsed:0.1f}G / {swapTotal:0.1f}G";
            on-click = "kitty -e htop";
          };

          "custom/uptime" = {
            format = "{}";
            format-icon = [ "" ];
            tooltip = false;
            interval = 1600;
            exec = "$/etc/nixos/modules/waybar/scripts/uptime.sh";
          };

          backlight = {
            format = "{icon}  {percent}%";
            format-icons = [
              "" "󰃜" "󰃛" "󰃞" "󰃝" "󰃟" "󰃠"
            ];
            tooltip = false;
          };

          pulseaudio = {
            format = "{icon}  {volume}%";
            format-muted = "";
            format-icons = {
              default = [ "" "" " " ];
            };
            on-click = "pavucontrol";
          };

          battery = {
            interval = 2;
            states = {
              warning = 30;
              critical = 15;
            };
            format = " {capacity}%";
            format-full = " {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = " {time}";
            format-icons = [ "" "" "" "" "" ];
          };

          "custom/lock" = {
            tooltip = false;
            on-click = "sh -c '(sleep 0s; hyprlock)' & disown";
            format = "";
          };

          "custom/pomodoro" = {
            format = "{}";
            return-type = "json";
            exec = "waybar-module-pomodoro --no-work-icons";
            on-click = "waybar-module-pomodoro toggle";
            on-click-right = "waybar-module-pomodoro reset";
          };
        }
      ];

      style = ''
        /* --- Global Styles --- */
        * {
          font-family: 'JetBrainsMono Nerd Font', 'Symbols Nerd Font', monospace;
          font-size: 14px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: #c6d0f5;
          margin: 0px;
          font-weight: 500;
        }

        /* --- Power Button --- */
        #custom-power {
          background-color: #e78284;
          color: #1a1b26;
          padding: 0.3rem 0.8rem;
          margin: 5px 0px;
          margin-left: 7px;
          margin-right: 5px;
          border-radius: 6px;
          font-size: 16px;
          font-weight: bold;
          box-shadow: 0 1px 3px rgba(231,130,132,0.3);
          transition: all 0.2s ease-in-out;
        }

        #custom-power:hover {
          background-color: #ea999c;
          box-shadow: 0 2px 6px rgba(231,130,132,0.5);
        }

        /* --- Left Modules --- */
        #workspaces,
        #custom-uptime,
        #cpu,
        #memory {
          background-color: #1a1b26;
          padding: 0.3rem 0.7rem;
          margin: 5px 0px;
          border-radius: 6px;
          box-shadow: 0 1px 3px rgba(0,0,0,0.1);
          transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        #workspaces { padding: 2px; margin-right: 5px; }
        #custom-uptime { margin-right: 5px; }
        #cpu { margin-right: 5px; }

        #custom-uptime:hover,
        #cpu:hover,
        #memory:hover { background-color: rgb(41, 42, 53); }

        #workspaces button {
          color: #babbf1;
          border-radius: 5px;
          padding: 0.3rem 0.6rem;
          background: transparent;
          transition: all .2s;
        }

        #workspaces button.active {
          color: #99d1db;
          background-color: rgba(153, 209, 219, 0.1);
        }

        #workspaces button:hover {
          background: rgb(41,42,53);
          color: #c6d0f5;
        }

        /* --- Center --- */
        #clock {
          background-color: #1a1b26;
          padding: 0.3rem 0.7rem;
          margin: 5px 0px;
          border-radius: 6px;
          box-shadow: 0 1px 3px rgba(153,209,219,0.2);
        }

        #clock:hover { background-color: rgba(153,209,219,0.1); }

        /* Pomodoro */
        #custom-pomodoro {
          background-color: #1a1b26;
          padding: 0.3rem 0.7rem;
          margin: 5px 0px;
          border-radius: 6px;
          transition: .2s;
          color: #babbf1;
        }

        #custom-pomodoro:hover {
          background-color: rgb(41,42,53);
          color: #c6d0f5;
          outline: 1px solid rgba(255,255,255,0.1);
          outline-offset: -1px;
        }

        #custom-pomodoro.work,
        #custom-pomodoro.break {
          color: #99d1db;
          background-color: rgba(153,209,219,0.1);
        }

        /* --- Right Modules --- */
        #bluetooth,
        #pulseaudio,
        #backlight,
        #network,
        #custom-lock,
        #battery {
          background-color: #1a1b26;
          padding: 0.3rem 0.7rem;
          margin: 5px 0px;
        }

        #bluetooth {
          border-top-left-radius: 6px;
          border-bottom-left-radius: 6px;
          color: #888;
        }
        #battery {
          border-top-right-radius: 6px;
          border-bottom-right-radius: 6px;
          margin-right: 7px;
        }

        /* Colors */
        #battery { color:#99d1db; }
        #battery.charging { color:#a6d189; }
        #battery.warning:not(.charging) { color:#e78284; }
        #bluetooth.connected { color:#99d1db; }

        tooltip {
          background-color: #1a1b26;
          color: #dddddd;
          padding: 5px 12px;
          border: 1px solid rgba(255,255,255,0.1);
          border-radius: 6px;
        }
      '';
    };

    # Installer wlogout pour le menu power
    home.packages = with pkgs; [
      wlogout
    ];

    # Configuration de wlogout
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
          label = "logout";
          action = "hyprctl dispatch exit";
          text = "Déconnexion";
          keybind = "e";
        }
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Éteindre";
          keybind = "s";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Veille";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Redémarrer";
          keybind = "r";
        }
      ];
      style = ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: rgba(26, 27, 38, 0.95);
        }

        button {
          border-radius: 8px;
          border: 2px solid #1a1b26;
          background-color: #1a1b26;
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          color: #c6d0f5;
          margin: 10px;
          transition: all 0.2s ease-in-out;
        }

        button:hover {
          background-color: rgba(153, 209, 219, 0.1);
          border-color: #99d1db;
          color: #99d1db;
        }

        button:focus {
          background-color: #99d1db;
          color: #1a1b26;
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