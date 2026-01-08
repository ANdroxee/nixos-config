{ config, ... }:

if config.hyprland.isDualMonitor then ''
################
### MONITORS ###
################


monitor=desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861,1920x1080@240,0x0,1


monitor=desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786,1680x1050@60,1920x0,1

##################
### WORKSPACES ###
##################

workspace=1,monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace=2,monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace=3,monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace=4,monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861
workspace=5,monitor:desc:ASUSTek COMPUTER INC VG27VQM R1LMDW005861

workspace=6,monitor:desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786
workspace=7,monitor:desc:Philips Consumer Electronics Company Philips 220V4 UK41531015786

'' else ''
monitor=,preferred,auto,1
''