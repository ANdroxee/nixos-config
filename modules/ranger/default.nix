{ config, pkgs, ... }:

{
  programs.ranger = {
    enable = true;
    
    # Plugins utiles
    plugins = [
      {
        name = "ranger_devicons";
        src = pkgs.fetchFromGitHub {
          owner = "alexanderjeurissen";
          repo = "ranger_devicons";
          rev = "9c18547cf03270ac64e71ec1ae4f4b9065ac7c5c";
          sha256 = "sha256-f5wHZ6VmoR/GtvAj+FEaDc7tQj6LRxFbxX9udVdH3cg=";
        };
      }
    ];
    
    settings = {
      # Affichage
      preview_images = true;
      preview_images_method = "kitty";  # Compatible avec Kitty terminal
      draw_borders = "both";
      column_ratios = "1,3,4";
      
      # Comportement
      show_hidden = true;
      confirm_on_delete = "multiple";
      use_preview_script = true;
      
      # Navigation
      automatically_count_files = true;
      open_all_images = true;
      
      # Performance
      vcs_aware = true;
      collapse_preview = true;
    };
    
    # Raccourcis personnalisés
    mappings = {
      # Navigation rapide
      "gd" = "cd ~/Downloads";
      "gc" = "cd ~/.config";
      "ge" = "cd /etc/nixos";
      "gh" = "cd ~";
      
      # Actions
      "DD" = "console delete";
      "x" = "shell chmod +x %f";
      
      # Ouvrir avec des applications
      "bg" = "shell feh --bg-scale %f";  # Définir comme fond d'écran
    };
    
    # Commandes personnalisées
    rifle = [
      {
        condition = "ext pdf";
        command = "zathura \"$@\"";
      }
      {
        condition = "ext png|jpg|jpeg|gif";
        command = "feh \"$@\"";
      }
      {
        condition = "mime ^text";
        command = "nvim \"$@\"";
      }
    ];
  };
  
  # Packages supplémentaires pour améliorer Ranger
  home.packages = with pkgs; [
    ranger
    # Prévisualisations
    file          # Détection de type de fichier
    imagemagick   # Preview images
    ffmpegthumbnailer  # Preview vidéos
    poppler_utils # Preview PDF
    
    # Outils optionnels
    feh           # Visionneuse d'images
    mediainfo     # Info médias
    highlight     # Coloration syntaxique
    atool         # Archives
    unzip
    p7zip
  ];
  
  # Alias Zsh pour Ranger
  programs.zsh.shellAliases = {
    r = "ranger";
    rr = "ranger .";
  };
}
