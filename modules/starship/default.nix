{ pkgs, lib, ... }:

{
  programs.starship = {
    enable = true;
    
    settings = {
      add_newline = true;
      
      format = lib.concatStrings [
        "$username"
        "$hostname"
        "$directory"
        "$git_branch"
        "$git_state"
        "$git_status"
        "$cmd_duration"
        "$line_break"
        "$python"
        "$character"
      ];

      character = {
        success_symbol = "[➜](bold green)";
        error_symbol = "[➜](bold red)";
      };

      directory = {
        style = "bold lavender";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      git_branch = {
        style = "bold pink";
        symbol = " ";
      };

      git_status = {
        style = "bold red";
        format = "[$all_status$ahead_behind]($style) ";
      };

      hostname = {
        ssh_only = false;
        format = "[$hostname]($style) ";
        style = "bold dimoted white";
      };

      cmd_duration = {
        min_time = 2000;
        format = "[$duration]($style) ";
        style = "bold yellow";
      };
      
      nix_shell = {
        symbol = " ";
        format = "[$symbol$state]($style) ";
      };
    };
  };
}
