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

  ########################################
  ## DISPLAY MANAGER + WAYLAND
  ########################################

  services.xserver.enable = false;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
  };

  services.displayManager.defaultSession = "hyprland";

  ########################################
  ## HYPRLAND
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
  ## INPUT
  ########################################

  services.seatd.enable = true;

  environment.sessionVariables = {
    TERMINAL = "kitty";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  ########################################
  ## AUDIO
  ########################################

  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  ########################################
  ## POLKIT + DBUS
  ########################################

  security.rtkit.enable = true;
  security.polkit.enable = true;

  services.dbus.enable = true;

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
  ## USER
  ########################################

  users.users.androxe = {
    isNormalUser = true;
    description = "androxe";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "input" "video" ];
  };

  programs.zsh.enable = true;

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
      };
    };
  };

  ########################################
  ## NIX SETTINGS
  ########################################

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  ########################################
  ## FONTS
  ########################################

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];


  ########################################
  ## Driver Nvidia
  ########################################
  # Active les drivers graphiques
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    open = false;
    nvidiaSettings = true;
    modesetting.enable = true;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  ########################################
  ## SYSTEM STATE VERSION
  ########################################

  system.stateVersion = "25.05";
}
