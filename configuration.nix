{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];


  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "androxe";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Paris";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "fr_FR.UTF-8";
    LC_IDENTIFICATION = "fr_FR.UTF-8";
    LC_MEASUREMENT = "fr_FR.UTF-8";
    LC_MONETARY = "fr_FR.UTF-8";
    LC_NAME = "fr_FR.UTF-8";
    LC_NUMERIC = "fr_FR.UTF-8";
    LC_PAPER = "fr_FR.UTF-8";
    LC_TELEPHONE = "fr_FR.UTF-8";
    LC_TIME = "fr_FR.UTF-8";
  };

  services.xserver.enable = true;
  services.libinput.enable = true;

  services.xserver.displayManager.gdm.enable = false;
  services.xserver.desktopManager.gnome.enable = false;


  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.displayManager.lightdm.background = pkgs.copyPathToStore ./wallpaper/wallpaper.jpg;
  services.xserver.displayManager.lightdm.greeters.gtk = {
    theme.name = "Adwaita-dark";
    indicators = [];
    extraConfig = ''
      show-clock = false
      show-indicators = 
      hide-user-image = true
    '';
   };
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.androxe = {
  isNormalUser = true;
  description = "androxe";
  shell = pkgs.zsh;
  extraGroups = [ "networkmanager" "wheel" "input" "video" ];
  packages = with pkgs; [];
};

programs.hyprland = {
  enable = true;
  xwayland.enable = true;
};

security.polkit.enable = true;
services.dbus.enable = true;

environment.sessionVariables = {
  TERMINAL = "kitty";
  WLR_NO_HARDWARE_CURSORS = "1";
  LIBSEAT_BACKEND = "logind";
};


  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    vim 
    wget
    wget
    kitty
    hyprland
    waybar
    wofi
    nwg-look
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-powerlevel10k
    gh-copilot
    gh
    discord
    code-cursor
    git
  ];

   hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
     General = {
      Enable = "Source,Sink,Media,Socket";
      };
    };
 };


 programs.zsh.enable = true;
 

   nix.settings.experimental-features = [ "nix-command" "flakes" ];


  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  system.stateVersion = "25.05"; 

}
