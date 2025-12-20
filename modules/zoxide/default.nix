{ pkgs, ... }:

{
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true; # (ou Bash/Fish)
    options = [
      "--cmd cd" # Remplace la commande 'cd' par zoxide automatiquement
    ];
  };
}
