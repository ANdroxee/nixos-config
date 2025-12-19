''
###################
### KEYBINDINGS ###
###################

$mainMod = SUPER

# --- Applications ---
bind = $mainMod, Q, exec, $terminal
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, R, exec, rofi -show drun
bind = $mainMod, L, exec, hyprlock

# --- Fenêtres ---
bind = $mainMod, C, killactive,
bind = $mainMod, M, exit, 
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Mode flottant sur F
bind = $mainMod, F, togglefloating, 

# --- Utilitaires ---
# On ajoute 'sh -c' et des guillemets pour sécuriser la commande
bind = , Print, exec, sh -c 'grim "$HOME/Pictures/Capture_$(date +%Y%m%d_%H%M%S).png"'

# Historique du Presse-papier (Super + V)
bind = $mainMod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy

# Pipette couleur (Super + N)
bind = $mainMod, N, exec, hyprpicker -a | wl-copy

# --- Navigation (Flèches) ---
bind = $mainMod, left, movefocus, l
bind = $mainMod, right, movefocus, r
bind = $mainMod, up, movefocus, u
bind = $mainMod, down, movefocus, d

# --- Workspaces (AZERTY - Touches du haut) ---
bind = $mainMod, code:10, workspace, 1
bind = $mainMod, code:11, workspace, 2
bind = $mainMod, code:12, workspace, 3
bind = $mainMod, code:13, workspace, 4
bind = $mainMod, code:14, workspace, 5
bind = $mainMod, code:15, workspace, 6
bind = $mainMod, code:16, workspace, 7
bind = $mainMod, code:17, workspace, 8
bind = $mainMod, code:18, workspace, 9
bind = $mainMod, code:19, workspace, 10

# --- Déplacer vers Workspace ---
bind = $mainMod SHIFT, code:10, movetoworkspace, 1
bind = $mainMod SHIFT, code:11, movetoworkspace, 2
bind = $mainMod SHIFT, code:12, movetoworkspace, 3
bind = $mainMod SHIFT, code:13, movetoworkspace, 4
bind = $mainMod SHIFT, code:14, movetoworkspace, 5
bind = $mainMod SHIFT, code:15, movetoworkspace, 6
bind = $mainMod SHIFT, code:16, movetoworkspace, 7
bind = $mainMod SHIFT, code:17, movetoworkspace, 8
bind = $mainMod SHIFT, code:18, movetoworkspace, 9
bind = $mainMod SHIFT, code:19, movetoworkspace, 10

# --- Special Workspace ---
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# --- Souris ---
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow

# --- Multimédia & Luminosité ---
bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+
bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
bindel = ,XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+
bindel = ,XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-

# --- Playerctl ---
bindl = , XF86AudioNext, exec, playerctl next
bindl = , XF86AudioPause, exec, playerctl play-pause
bindl = , XF86AudioPlay, exec, playerctl play-pause
bindl = , XF86AudioPrev, exec, playerctl previous
''