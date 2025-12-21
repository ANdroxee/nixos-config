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
  
  
  programs.ranger = {
    enable = true;
    settings = {
      preview_images = true;
      preview_images_method = "kitty";
      show_hidden = true;
      confirm_on_delete = "multiple";
    };
  };
  
  fonts.fontconfig.enable = true;
  
  home.packages = with pkgs; [
    hello
    hyprland
    waybar
    wofi
    nwg-look
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
    gh-copilot
    gh
    rofi
    psmisc 
    ranger
    file
    imagemagick
    ffmpegthumbnailer
    poppler-utils
    highlight     
    gnupg
    steam-run
  ];
  
  home.file = {};
  
  programs.home-manager.enable = true;
  
  imports = [
    ../../modules/waybar/default.nix
    ../../modules/hypr/default.nix
    ../../modules/rofi/rofi.nix
    ../../modules/hyprlock/default.nix
    ../../modules/hyprpaper/default.nix
    ../../modules/zsh/default.nix
    ../../modules/kitty/default.nix
    ../../modules/btop/default.nix
    ../../modules/fastfetch/default.nix
    ../../modules/starship/default.nix
    ../../modules/eza/default.nix
    ../../modules/bat/default.nix
    ../../modules/zoxide/default.nix
    ../../modules/cava/default.nix
    ../../modules/yazi/default.nix
    ../../modules/lazygit/default.nix
  ];
  
  hyprland.isDualMonitor = true;
  waybar.isLaptop = false;
  
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    settings = {
      "$mod" = "SUPER";

      # ---------------------------------------------------------
      # CONFIGURATION DES ÉCRANS (ARASAKA)
      # ---------------------------------------------------------
      monitor = [
        "DP-3, 1920x1080@240, 0x0, 1"

        "HDMI-A-1, 1680x1050@60, 1920x0, 1"
      ];

      # ---------------------------------------------------------
      # ASSIGNATION DES WORKSPACES
      # ---------------------------------------------------------
      workspace = [
        "1, monitor:DP-3"
        "2, monitor:DP-3"
        "3, monitor:DP-3"
        "4, monitor:DP-3"
        "5, monitor:DP-3"
        
        "6, monitor:HDMI-A-1"
        "7, monitor:HDMI-A-1"
      ];
    };
  };
}
