{ config, lib, pkgs, ... }:
let
  monitors = import ./config/monitors.nix { inherit config; };
  keybindings = import ./config/keybindings.nix;
  animations = import ./config/animations.nix;
  autostart = import ./config/autostart.nix;
in {
  options.hyprland = {
    isDualMonitor = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Whether the system has dual monitors.";
    };
  };

  config = {
    xdg.configFile."hypr/hyprland.conf".text = ''
  
  ${monitors}
  ${keybindings}
  ${animations}
  ${autostart}

  '';
  };
}
