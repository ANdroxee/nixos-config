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
            "hyprland/workspaces"
            "custom/uptime"
            "cpu"
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

          "hyprland/workspaces" = {
            format = "{name}: {icon}";
            format-icons = {
              active = "";
              default = "";
            };
          };

          bluetooth = {
            format = "󰂲";
            format-on = "{icon}";
            format-off = "{icon}";
            format-connected = "{icon}";
            format-icons = {
              on = "󰂯";
              off = "󰂲";
              connected = "󰂱";
            };
            on-click = "blueman-manager";
            tooltip-format-connected = "{device_enumerate}";
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
            format-wifi = "󰤢";
            format-ethernet = "󰈀 ";
            format-disconnected = "󰤠 ";
            interval = 5;
            tooltip-format = "{essid} ({signalStrength}%)";
            on-click = "nm-connection-editor";
          };

          cpu = {
            interval = 1;
            format = "  {icon0}{icon1}{icon2}{icon3} {usage:>2}%";
            format-icons = [ "▁" "▂" "▃" "▄" "▅" "▆" "▇" "█" ];
            on-click = "ghostty -e htop";
          };

          memory = {
            interval = 30;
            format = "  {used:0.1f}G/{total:0.1f}G";
            tooltip-format = "Memory";
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
            format = "{icon}  {capacity}%";
            format-full = "{icon}  {capacity}%";
            format-charging = " {capacity}%";
            format-plugged = " {capacity}%";
            format-alt = "{icon} {time}";
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
          font-family: 'SF Pro Text', 'Inter', 'Segoe UI, NotoSans Nerd Font', sans-serif;
          font-size: 13px;
          min-height: 0;
        }

        #waybar {
          background: transparent;
          color: #c6d0f5;
          margin: 0px;
          font-weight: 500;
        }

        /* --- Left Modules --- */
        #workspaces,
        #custom-uptime,
        #cpu {
          background-color: #1a1b26;
          padding: 0.3rem 0.7rem;
          margin: 5px 0px;
          border-radius: 6px;
          box-shadow: 0 1px 3px rgba(0,0,0,0.1);
          transition: background-color 0.2s ease-in-out, color 0.2s ease-in-out;
        }

        #workspaces { padding: 2px; margin-left: 7px; margin-right: 5px; }
        #custom-uptime { margin-right: 5px; }

        #custom-uptime:hover,
        #cpu:hover { background-color: rgb(41, 42, 53); }

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
  };
}