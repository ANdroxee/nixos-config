{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  ########################################
  ## BOOT
  ########################################
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  ########################################
  ## SYSTEM
  ########################################
  networking.hostName = "arasaka"; # <--- Le nom de la Corpo !
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

  ########################################
  ## DISPLAY MANAGER
  ########################################
  services.xserver.enable = false;
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    theme = "stray";
    package = pkgs.kdePackages.sddm; 
  };
  services.displayManager.defaultSession = "hyprland";

  ########################################
  ## HYPRLAND & GRAPHICS
  ########################################
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    config.common.default = "*";
  };

  ########################################
  ## AUDIO & SERVICES
  ########################################
  services.seatd.enable = true;
  security.rtkit.enable = true;
  security.polkit.enable = true;
  services.dbus.enable = true;
  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
    };
  };

  ########################################
  ## USER & ENV
  ########################################
  users.users.androxe = {
    isNormalUser = true;
    description = "androxe";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
  };

  programs.zsh.enable = true;
  
  environment.sessionVariables = {
    TERMINAL = "kitty";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  ########################################
  ## PACKAGES
  ########################################
  environment.systemPackages = with pkgs; [
    vim 
    wget
    kitty
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
    polkit_gnome
    firefox
    
    (catppuccin-sddm.override {
      flavor = "mocha";
      font  = "JetBrainsMono Nerd Font";
      loginBackground = true;
    })
  ];

  programs.firefox.enable = true;

  ########################################
  ## BLUETOOTH
  ########################################
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
  services.blueman.enable = true;

  ########################################
  ## NIX SETTINGS
  ########################################
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  fonts.packages = with pkgs; [ nerd-fonts.jetbrains-mono ];

  ########################################
  ## DRIVER NVIDIA (Desktop Version)
  ########################################
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;
   
  };

  system.stateVersion = "25.05";
}
