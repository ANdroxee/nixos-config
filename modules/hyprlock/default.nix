{ config, pkgs, ... }:

{
  # Activation de hyprlock
  programs.hyprlock.enable = true;

  # Dépendances pour les widgets (Météo, Musique, Batterie)
  # (Vous pouvez garder ces paquets s'ils vous sont utiles pour autre chose, 
  # sinon vous pouvez aussi supprimer ce bloc si vous n'en avez plus besoin).
  home.packages = with pkgs; [
    playerctl
    upower
    jq
    curl
  ];
}
