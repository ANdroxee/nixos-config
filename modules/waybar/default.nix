{ config, lib, pkgs, ... }:

{
  # On déclare les options que tu utilises dans ton home.nix
  options.waybar = {
    isLaptop = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Activer les modules spécifiques aux PC portables (ex: Batterie)";
    };

    enableMechabar = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Activer Waybar et la configuration Mechabar";
    };

    mechabarTheme = lib.mkOption {
      type = lib.types.str;
      default = "mocha";
      description = "Couleurs du thème Mechabar (ex: mocha, macchiato)";
    };
  };

  # Si enableMechabar est sur true dans ton home.nix, on applique cette configuration
  config = lib.mkIf config.waybar.enableMechabar {
    
    # On installe et active Waybar via Home Manager
    programs.waybar.enable = true;

    # Dépendances très courantes pour faire fonctionner les scripts Waybar/Mechabar
    home.packages = with pkgs; [
      rofi
      networkmanagerapplet
      pavucontrol
      playerctl
      swaybg
    ];
  };
}
