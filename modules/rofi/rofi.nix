{ pkgs, config, ... }:

let
  # --- TA PALETTE DE COULEURS (Thème "Stray") ---
  colors = {
    bg = "#191724";        # Fond très sombre
    bg-alt = "#1f1d2e";    # Fond un peu plus clair
    border = "#ebbcba";    # Bordure (Rose/Orange pâle)
    selected = "#26233a";  # Sélection
    accent = "#f6c177";    # Accent (Orange/Or)
    text = "#e0def4";      # Texte principal
    text-alt = "#908caa";  # Texte secondaire
  };
in
{
  home.packages = with pkgs; [ rofi ];

  xdg.configFile."rofi/theme.rasi".text = ''
    * {
      bg-col: ${colors.bg};
      bg-col-light: ${colors.bg-alt};
      border-col: ${colors.border};
      selected-col: ${colors.selected};
      highlight: ${colors.accent};
      fg-col: ${colors.text};
      fg-col2: ${colors.text-alt};
      grey: ${colors.text-alt};
    }
  '';

  xdg.configFile."rofi/config.rasi".text = ''
    configuration {
      modi: "drun"; 
      lines: 10;
      cycle: true;
      font: "Maple Mono Bold 14";
      show-icons: true;
      icon-theme: "Papirus-dark";
      terminal: "ghostty";
      drun-display-format: "{icon} {name}";
      location: 0;
      disable-history: false;
      hide-scrollbar: true;
      display-drun: " 🚀 Apps ";
      sidebar-mode: false;
      sorting-method: "fzf";
    }

    @theme "theme"

    element-text, element-icon {
      background-color: inherit;
      text-color:       inherit;
    }

    window {
      height: 600px;
      width: 900px;  /* <--- C'est ici que j'ai élargi la fenêtre */
      border: 2px;
      border-radius: 12px;
      border-color: @border-col;
      background-color: @bg-col;
    }

    mainbox {
      background-color: @bg-col;
    }

    inputbar {
      children: [prompt, entry];
      background-color: @bg-col-light;
      border-radius: 8px;
      padding: 2px;
      margin: 20px 20px 0px 20px;
    }

    prompt {
      background-color: @highlight;
      padding: 6px;
      text-color: @bg-col;
      border-radius: 6px;
      margin: 10px 0px 10px 10px;
      font: "Maple Mono Bold 12";
    }

    textbox-prompt-colon {
      expand: false;
      str: ":";
    }

    entry {
      padding: 6px;
      margin: 10px 10px 10px 5px;
      text-color: @fg-col;
      background-color: @bg-col-light;
      placeholder: "Lancer une application...";
      placeholder-color: @grey;
    }

    listview {
      border: 0px;
      padding: 6px 0px 0px;
      margin: 10px 20px 0px 20px;
      columns: 1;
      background-color: @bg-col;
      cycle: true;
    }

    element {
      padding: 12px;
      margin: 4px 0px;
      background-color: @bg-col;
      text-color: @fg-col;
      border-radius: 8px;
    }

    element-icon {
      size: 32px;
      padding: 0px 15px 0px 0px;
    }

    element selected {
      background-color: @selected-col;
      text-color: @highlight;
      border: 1px;
      border-color: @border-col;
    }
  '';
}