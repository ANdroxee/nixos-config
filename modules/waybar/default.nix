{ config, lib, pkgs, ... }:
{
  options.waybar = {
    isLaptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system is a laptop.";
    };
  };

  config = {
    home.packages = with pkgs; [
      wlogout
      pavucontrol
    ];

    programs.waybar = {
      enable = true;
      systemd = {
        enable = false;
        target = "graphical-session.target";
      };
      settings = [
        {
          layer = "bottom";
          position = "top";
          height = 40;
          spacing = 2;
          exclusive = true;
          "gtk-layer-shell" = true;
          passthrough = false;
          "fixed-center" = true;

          modules-left = [ "custom/logo" "hyprland/window" ];
          modules-center = [ "hyprland/workspaces" ];
          modules-right = [
            "cpu"
            "memory"
            "pulseaudio"
            "clock"
            "clock#simpleclock"
            "tray"
            "custom/power"
          ] ++ (if config.waybar.isLaptop then [ "custom/battery" ] else []);

          "hyprland/workspaces" = {
            "on-click" = "activate";
            format = "{id}";
            "all-outputs" = true;
            "disable-scroll" = false;
            "active-only" = false;
            "sort-by-number" = true;
          };

          "hyprland/window" = {
            format = "{title}";
          };

          tray = {
            "show-passive-items" = true;
            spacing = 10;
          };

          "clock#simpleclock" = {
            tooltip = false;
            format = " {:%H:%M}";
          };

          clock = {
            format = "{:L%a %d %b}";
            calendar = {
              format = {
                days = "<span weight='normal'>{}</span>";
                months = "<span color='#cdd6f4'><b>{}</b></span>";
                today = "<span color='#f38ba8' weight='700'><u>{}</u></span>";
                weekdays = "<span color='#f9e2af'><b>{}</b></span>";
                weeks = "<span color='#a6e3a1'><b>W{}</b></span>";
              };
              mode = "month";
              "mode-mon-col" = 1;
              "on-scroll" = 1;
            };
            "tooltip-format" = "<span color='#cdd6f4' font='Lexend 16'><tt><small>{calendar}</small></tt></span>";
          };

          cpu = {
            format = " {usage}%";
            tooltip = true;
            interval = 1;
          };

          memory = {
            format = " {used:0.1f}Gi";
          };

          pulseaudio = {
            format = "{icon} {volume}%";
            "format-muted" = "  muted";
            "format-icons" = {
              headphone = "";
              default = [ " " " " " " ];
            };
            "on-click" = "pavucontrol";
          };

          "custom/sep" = {
            format = "|";
            tooltip = false;
          };

          "custom/power" = {
            tooltip = false;
            "on-click" = "wlogout -p layer-shell &";
            format = "⏻";
          };

          "custom/logo" = {
            format = "❄️";
            tooltip = false;
          };

          "custom/battery" = {
            exec = "bash -c 'capacity=$(cat /sys/class/power_supply/BAT*/capacity 2>/dev/null || echo 100); capacity=\${capacity:-100}; bars=\$((capacity / 10)); empty=\$((10 - bars)); filled=\"\"; empty_bars=\"\"; for i in \$(seq 1 \$bars); do filled=\"\$filled█\"; done; for i in \$(seq 1 \$empty); do empty_bars=\"\$empty_bars░\"; done; echo \"\$filled\$empty_bars \${capacity}%\"'";
            interval = 30;
            tooltip = false;
          };
        }
      ];
      style = ''
        * {
          min-height: 0;
          min-width: 0;
          font-family: Lexend, "JetBrainsMono NFP";
          font-size: 16px;
          font-weight: 600;
        }

        window#waybar {
          transition-property: background-color;
          transition-duration: 0.5s;
          /* background-color: #1e1e2e; */
          /* background-color: #181825; */
          /* background-color: #11111b; */
          background-color: rgba(24, 24, 37, 0);
        }

        #workspaces button {
          padding: 0.3rem 0.6rem;
          margin: 0.4rem 0.25rem;
          border-radius: 6px;
          /* background-color: #181825; */
          background-color: #1e1e2e;
          color: #cdd6f4;
        }

        #workspaces button:hover {
          color: #1e1e2e;
          background-color: #cdd6f4;
        }

        #workspaces button.active {
          background-color: #1e1e2e;
          color: #89b4fa;
        }

        #workspaces button.urgent {
          background-color: #1e1e2e;
          color: #f38ba8;
        }

        #clock,
        #pulseaudio,
        #custom-logo,
        #custom-power,
        #cpu,
        #tray,
        #memory,
        #window,
        #custom-battery {
          padding: 0.3rem 0.6rem;
          margin: 0.4rem 0.25rem;
          border-radius: 6px;
          /* background-color: #181825; */
          background-color: #1e1e2e;
        }

    /* mpris styles removed with mpris module */

        #custom-sep {
          padding: 0px;
          color: #585b70;
        }

        window#waybar.empty #window {
          background-color: transparent;
        }

        #cpu {
          color: #ffffff;
        }

        #memory {
          color: #77b2e1;
        }

        #clock {
          color: #74c7ec;
        }

        #clock.simpleclock {
          color: #89b4fa;
        }

        #window {
          color: #cdd6f4;
        }

        #pulseaudio {
          color: #7cb2e4;
        }

        #pulseaudio.muted {
          color: #a6adc8;
        }

        #custom-battery {
          color: #a6e3a1;
        }

        #custom-battery.charging {
          color: #f9e2af;
        }

        #custom-battery.warning:not(.charging) {
          color: #f38ba8;
        }

        #custom-logo {
          color: #ffffff;
        }

        #custom-power {
          color: #f38ba8;
        }

        tooltip {
          background-color: #181825;
          border: 2px solid #89b4fa;
        }
      '';
    };
  };
}
