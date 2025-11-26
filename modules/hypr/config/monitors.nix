{ config }:
if config.hyprland.isDualMonitor then ''
################
### MONITORS ###
################
# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=,preferred,auto,1
###################
### MY PROGRAMS ###
###################
# See https://wiki.hyprland.org/Configuring/Keywords/
# Set programs that you use
$terminal = kitty
$fileManager = dolphin
$menu = wofi --show drun
windowrule = suppressevent maximize, class:.*
# Fix some dragging issues with XWayland
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
'' else ''
################
### MONITORS ###
################
monitor=,preferred,auto,auto
###################
### MY PROGRAMS ###
###################
$terminal = kitty
$fileManager = dolphin
$menu = wofi --show drun
windowrule = suppressevent maximize, class:.*
windowrule = nofocus,class:^$,title:^$,xwayland:1,floating:1,fullscreen:0,pinned:0
''