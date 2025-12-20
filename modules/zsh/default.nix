{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      #ll = "ls -la";
      update = "sudo nixos-rebuild switch";
      hm = "home-manager switch";
      #ls = "ls --color=auto";
      grep = "grep --color=auto";
    };
    
    history = {
      size = 10000;
      path = "${config.home.homeDirectory}/.zsh_history";
    };
    
    # Utiliser initContent au lieu de initExtra
    initContent = ''
      # Powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi
      
      # Powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      
      # Powerlevel10k config
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      
      # Raccourcis clavier utiles
      bindkey '^[[A' history-search-backward
      bindkey '^[[B' history-search-forward
    '';
    
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];
  };
  
  # Définir Zsh comme shell par défaut
  home.sessionVariables = {
    SHELL = "${pkgs.zsh}/bin/zsh";
  };
}