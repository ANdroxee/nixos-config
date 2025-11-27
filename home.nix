{ config, pkgs, ... }:
{
  home.username = "androxe";
  home.homeDirectory = "/home/androxe";
  home.stateVersion = "25.05";
  
  nixpkgs.config.allowUnfree = true;
  
  gtk.enable = true;
  gtk.gtk3.theme = {
    name = "Adwaita-dark";
  };
  
  programs.git = {
    enable = true;
    userName = "ANdroxee";
    userEmail = "anto.dongay123@gmail.com";
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
  ];
  
  home.file = {};
  
  programs.home-manager.enable = true;
  
  imports = [
    ./modules/waybar/default.nix
    ./modules/hypr/default.nix
    ./modules/rofi/rofi.nix
    ./modules/hyprlock/default.nix
  ];
  
  hyprland.isDualMonitor = true;
  waybar.isLaptop = true;

  wayland.windowManager.hyprland = {
  enable = true;
  package = null;
  portalPackage = null;
};
}
