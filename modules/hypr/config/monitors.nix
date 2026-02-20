{ config, pkgs, osConfig, ... }:

let
  hostname = osConfig.networking.hostName;
in

if hostname == "arasaka" then ''
################
### MONITORS ###
################

monitor=desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861,1920x1080@240,0x0,1
monitor=desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786,1680x1050@60,1920x0,1

workspace = 1, monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace = 2, monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace = 3, monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace = 4, monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace = 5, monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861

workspace = 6, monitor:desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786
workspace = 7, monitor:desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786

##############################
### WINDOWS AND WORKSPACES ###
##############################

# Nouvelle syntaxe windowrule (windowrulev2 est déprécié depuis Hyprland 0.48+)
windowrule = match:class ^$ match:title ^$ match:xwayland on match:floating on match:fullscreen off match:pinned off, no_focus on

windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, float on
windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, size 1200 800
windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, center on

'' else ''
################
### MONITORS ###
################

monitor=eDP-1,1920x1080@144,0x0,1
monitor=,preferred,auto,1

##############################
### WINDOWS AND WORKSPACES ###
##############################

windowrule = match:class ^$ match:title ^$ match:xwayland on match:floating on match:fullscreen off match:pinned off, no_focus on

windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, float on
windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, size 1200 800
windowrule = match:class ^(org.pulseaudio.pavucontrol|blueman-manager|nm-connection-editor)$, center on
''