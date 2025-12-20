{ pkgs, ... }:

{
  programs.eza = {
    enable = true;
    enableZshIntegration = true; # (ou enableBashIntegration = true selon ton shell)
    git = true;      # Affiche le statut git des fichiers
    icons = "auto";  # Affiche les icônes (nécessite une Nerd Font)
  };
  
  # On crée des alias pour ne plus jamais taper "ls"
  home.shellAliases = {
    ls = "eza";
    ll = "eza -l --icons --git -a";
    lt = "eza --tree --level=2 --long --icons --git";
  };
}
