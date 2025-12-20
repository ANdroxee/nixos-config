{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true; # (ou enableBashIntegration)
    
    # Configuration optionnelle pour le look
    theme = {
      manager = {
        show_hidden = true;
        sort_by = "natural";
      };
    };
  };

  # Alias pour aller vite
  home.shellAliases = {
    r = "yazi"; # Tape juste "r" pour ouvrir le gestionnaire de fichiers
  };
}
