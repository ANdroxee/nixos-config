{ pkgs, ... }:

{
  home.packages = with pkgs; [ cava ];

  xdg.configFile."cava/config".text = ''
    [color]
    gradient = 1
    gradient_count = 6
    gradient_color_1 = '#9ccfd8'
    gradient_color_2 = '#c4a7e7'
    gradient_color_3 = '#eb6f92'
    gradient_color_4 = '#f6c177'
    gradient_color_5 = '#ebbcba'
    gradient_color_6 = '#e0def4'
  '';
}
