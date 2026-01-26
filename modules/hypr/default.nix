
{ config, lib, pkgs, osConfig, ... }:

let
  monitors = import ./config/monitors.nix { inherit config pkgs osConfig; };
  
  keybindings = import ./config/keybindings.nix;
  animations = import ./config/animations.nix;
  autostart = import ./config/autostart.nix { inherit config pkgs osConfig; };
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