{ config, pkgs, ... }:
{
  home.username = "androxe";
  home.homeDirectory = "/home/androxe";
  home.stateVersion = "25.05";
  
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
  
  # Ranger configuration
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      show_hidden = true;
      confirm_on_delete = "multiple";
    };
  };
  
  # Activer fontconfig pour les Nerd Fonts
  fonts.fontconfig.enable = true;
  
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
    pkgs.psmisc 
    pkgs.ranger
    pkgs.file
    pkgs.imagemagick
    pkgs.ffmpegthumbnailer
    pkgs.poppler-utils
    pkgs.highlight
    pkgs.atool
    pkgs.unzip
    pkgs.p7zip
    pkgs.brightnessctl
    pkgs.grim        
    pkgs.slurp        
    pkgs.wl-clipboard
    pkgs.cliphist
    pkgs.hyprpicker
    pkgs.gnupg
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
    ./modules/kitty/default.nix
    ./modules/btop/default.nix
    ./modules/fastfetch/default.nix
    ./modules/starship/default.nix
    ./modules/eza/default.nix
    ./modules/bat/default.nix
    ./modules/zoxide/default.nix
    ./modules/cava/default.nix
  ];
  
  hyprland.isDualMonitor = true;
  waybar.isLaptop = true;
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";
    };
  };
}