{ config, pkgs, ... }:
{
  home.username = "androxe";
  home.homeDirectory = "/home/androxe";
  home.stateVersion = "25.05";
  
  # Retirer nixpkgs.config si vous utilisez useGlobalPkgs
  # nixpkgs.config.allowUnfree = true;
  
  gtk.enable = true;
  gtk.gtk3.theme = {
    name = "Adwaita-dark";
  };
  
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "ANdroxee";
        email = "anto.dongay123@gmail.com";
      };
    };
  };
  
  home.sessionVariables = {
    TERMINAL = "kitty";
  };
  
  home.packages = [
    pkgs.hello
    pkgs.hyprland
    pkgs.waybar
    pkgs.wofi
    pkgs.nwg-look
    pkgs.zsh-autosuggestions
    pkgs.zsh-syntax-highlighting
    pkgs.zsh-powerlevel10k
    pkgs.gh-copilot
    pkgs.gh
    pkgs.rofi
    pkgs.ranger
    pkgs.file
    pkgs.imagemagick
    pkgs.ffmpegthumbnailer
    pkgs.poppler-utils
    pkgs.highlight
    pkgs.atool
    pkgs.unzip
    pkgs.p7zip
  ];
  
  home.file = {};
  
  programs.home-manager.enable = true;
  
  imports = [
    ./modules/waybar/default.nix
    ./modules/hypr/default.nix
    ./modules/rofi/rofi.nix
    ./modules/hyprlock/default.nix
    ./modules/hyprpaper/default.nix
    ./modules/zsh/default.nix
    #./modules/ranger/default.nix
  ];
  
  hyprland.isDualMonitor = true;
  waybar.isLaptop = true;
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      # Ajoutez au moins une configuration basique
      "$mod" = "SUPER";
    };
  };
}