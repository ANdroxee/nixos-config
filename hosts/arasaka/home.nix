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
    grim
    slurp
    wl-clipboard
    cliphist
    hyprpicker
    cbonsai
    pavucontrol
    duf
    hyprpaper
    ncdu
  ];
  
  home.file = {};
  
  programs.home-manager.enable = true;

  hyprland.isDualMonitor = true;
  
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

}