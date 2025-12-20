{ pkgs, ... }:

{
  home.packages = with pkgs; [ fastfetch ];

  xdg.configFile."fastfetch/config.jsonc".text = ''
    {
      "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
      "logo": {
        "source": "nixos_small",  // <--- C'est ici que la magie opère
        "padding": {
          "top": 2,
          "left": 1,
          "right": 2
        },
        "color": {
          "1": "cyan",      // Couleur principale du logo (NixOS Blue)
          "2": "blue"       // Couleur secondaire
        }
      },
      "display": {
        "separator": "  ",
        "color": {
          "keys": "magenta",
          "title": "blue"
        }
      },
      "modules": [
        {
            "type": "title",
            "format": "{user}@{host-name}"
        },
        "break",
        {
            "type": "os",
            "key": " OS",
            "keyColor": "blue"
        },
        {
            "type": "kernel",
            "key": " Kernel",
            "keyColor": "blue"
        },
        {
            "type": "packages",
            "key": "󰏖 Packages",
            "keyColor": "blue"
        },
        {
            "type": "shell",
            "key": " Shell",
            "keyColor": "blue"
        },
        "break",
        {
            "type": "wm",
            "key": " WM",
            "keyColor": "yellow"
        },
        {
            "type": "terminal",
            "key": " Terminal",
            "keyColor": "yellow"
        },
        {
            "type": "uptime",
            "key": "󰅐 Uptime",
            "keyColor": "yellow"
        },
        "break",
        {
            "type": "cpu",
            "key": " CPU",
            "keyColor": "green"
        },
        {
            "type": "memory",
            "key": " Memory",
            "keyColor": "green"
        },
        {
            "type": "disk",
            "key": " Disk",
            "keyColor": "green"
        },
        "break",
        "colors"
      ]
    }
  '';
}