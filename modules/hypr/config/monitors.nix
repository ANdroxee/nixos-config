{ config, ... }:

if config.hyprland.isDualMonitor then ''
# -----------------------------------------------------
# CONFIGURATION FINALISÉE
# -----------------------------------------------------

# 1. Écran DP-2 (Principal - Gamer) à GAUCHE (0x0)
# On force le 240Hz
monitor=DP-2,1920x1080@240,0x0,1

# 2. Écran HDMI (Secondaire) à DROITE
# Il commence à 1920 (juste après le principal)
monitor=HDMI-A-1,1680x1050@60,1920x0,1

# Workspaces sur DP-2
workspace=1,monitor:DP-2
workspace=2,monitor:DP-2
workspace=3,monitor:DP-2
workspace=4,monitor:DP-2
workspace=5,monitor:DP-2

# Workspaces sur HDMI
workspace=6,monitor:HDMI-A-1
workspace=7,monitor:HDMI-A-1
workspace=8,monitor:HDMI-A-1
workspace=9,monitor:HDMI-A-1
workspace=10,monitor:HDMI-A-1

'' else ''
# Mode Solo
monitor=,preferred,auto,1
''