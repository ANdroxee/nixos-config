{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    
    theme = "Catppuccin-Mocha";

    font = {
      name = "JetBrainsMono Nerd Font";
      size = 12;
    };

    settings = {
      background_opacity = "0.8";
      window_padding_width = 10;
      
      confirm_os_window_close = 0; 
      enable_audio_bell = false;   
      copy_on_select = true;      
      
      shell_integration = "enabled";
    };
  };

  home.packages = with pkgs; [
    pkgs.nerd-fonts.jetbrains-mono
  ];
}
