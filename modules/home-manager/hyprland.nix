{ config, pkgs, inputs, ... }:

{
  imports = [ inputs.hyprland.homeManagerModules.default ];
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    extraConfig = ''
      $rosewaterAlpha = f5e0dc
      $flamingoAlpha  = f2cdcd
      $pinkAlpha      = f5c2e7
      $mauveAlpha     = cba6f7
      $redAlpha       = f38ba8
      $maroonAlpha    = eba0ac
      $peachAlpha     = fab387
      $yellowAlpha    = f9e2af
      $greenAlpha     = a6e3a1
      $tealAlpha      = 94e2d5
      $skyAlpha       = 89dceb
      $sapphireAlpha  = 74c7ec
      $blueAlpha      = 89b4fa
      $lavenderAlpha  = b4befe

      $textAlpha      = cdd6f4
      $subtext1Alpha  = bac2de
      $subtext0Alpha  = a6adc8

      $overlay2Alpha  = 9399b2
      $overlay1Alpha  = 7f849c
      $overlay0Alpha  = 6c7086

      $surface2Alpha  = 585b70
      $surface1Alpha  = 45475a
      $surface0Alpha  = 313244

      $baseAlpha      = 1e1e2e
      $mantleAlpha    = 181825
      $crustAlpha     = 11111b

      $rosewater = 0xfff5e0dc
      $flamingo  = 0xfff2cdcd
      $pink      = 0xfff5c2e7
      $mauve     = 0xffcba6f7
      $red       = 0xfff38ba8
      $maroon    = 0xffeba0ac
      $peach     = 0xfffab387
      $yellow    = 0xfff9e2af
      $green     = 0xffa6e3a1
      $teal      = 0xff94e2d5
      $sky       = 0xff89dceb
      $sapphire  = 0xff74c7ec
      $blue      = 0xff89b4fa
      $lavender  = 0xffb4befe

      $text      = 0xffcdd6f4
      $subtext1  = 0xffbac2de
      $subtext0  = 0xffa6adc8

      $overlay2  = 0xff9399b2
      $overlay1  = 0xff7f849c
      $overlay0  = 0xff6c7086

      $surface2  = 0xff585b70
      $surface1  = 0xff45475a
      $surface0  = 0xff313244

      $base      = 0xff1e1e2e
      $mantle    = 0xff181825
      $crust     = 0xff11111b

      $mainMod = SUPER

      exec-once = pypr
      #-- Output ----------------------------------------------------
      monitor=HDMI-A-1,3440x1440@99.991997,1280x0,1
      monitor=eDP-1,2560x1600@120,0x0,2
      #-copeFuzzyCommandSearch) Input ----------------------------------------------------
      # Configure mouse and touchpad here.
      input {
          kb_layout=
          kb_variant=
          kb_model=
          kb_options=
          kb_rules=
          follow_mouse=1
          natural_scroll=0
      	force_no_accel=0
      }

      gestures {
          workspace_swipe=1
          workspace_swipe_fingers=3
          workspace_swipe_distance=200
          workspace_swipe_min_speed_to_force=100
        }

      #-- General ----------------------------------------------------
      # General settings like MOD key, Gaps, Colors, etc.
      general {
          sensitivity=1.0
      	 apply_sens_to_raw=0

          gaps_in=5
          gaps_out=10

          border_size=5
          no_border_on_floating=0
          col.active_border=$blue
          col.inactive_border=0xFF343A40

          layout = dwindle
          # damage_tracking=2 # leave it on full unless you hate your GPU and want to make it suffer
      }
       # xwayland {
       # force_zero_scaling = true
       # }
      #-- Decoration ----------------------------------------------------
      # Decoration settings like Rounded Corners, Opacity, Blur, etc.
      decoration {
          rounding=8
      #    multisample_edges=1

          active_opacity=1.0
          inactive_opacity=1.0
          fullscreen_opacity=1.0

       blur {
             enabled=true
            size=1
            passes=4
            ignore_opacity=true
            new_optimizations=true
          }


          # Your blur "amount" is blur_size * blur_passes, but high blur_size (over around 5-ish) will produce artifacts.
          # if you want heavy blur, you need to up the blur_passes.
          # the more passes, the more you can up the blur_size without noticing artifacts.
      }

      #-- Animations ----------------------------------------------------
      animations {
          enabled=1
          animation=windows,1,5,default
          animation=border,1,10,default
          animation=fade,1,8,default
          animation=workspaces,1,3,default
      }

      #-- Dwindle ----------------------------------------------------
      # dwindle {
      #    pseudotile=0 			# enable pseudotiling on dwindle
      # }

      #-- Misc --------------------------------------------------------
      misc {
        mouse_move_enables_dpms=1
        disable_hyprland_logo = true
        vfr =true
      }

      # -- workspace --
      workspace=1,monitor:HDMI-A-1
      workspace=2,monitor:HDMI-A-1
      workspace=3,monitor:HDMI-A-1
      workspace=4,monitor:HDMI-A-1
      workspace=5,monitor:HDMI-A-1
      workspace=6,monitor:eDP-1
      workspace=7,monitor:eDP-1
      workspace=8,monitor:eDP-1
      workspace=9,monitor:eDP-1
      workspace=10,monitor:eDP-1

      # -- Float applications --
      windowrule=float,yad|nm-connection-editor|pavucontrolk|xfce-polkit|kvantummanager|qt5ct|feh|Viewnior|Gpicview|Gimp|MPlayer|VirtualBox Manager|qemu|Qemu-system-x86_64|mpv

      # -- Center for float applications --
      windowrule=center,yad|nm-connection-editor|pavucontrolk|xfce-polkit|kvantummanager|qt5ct|feh|Viewnior|Gpicview|Gimp|MPlayer|VirtualBox Manager|qemu|Qemu-system-x86_64|mpv
       $scratchpadsize = size 80% 85%

             $scratchpad = class:^(scratchpad)$
             windowrulev2 = float,$scratchpad
             windowrulev2 = $scratchpadsize,$scratchpad
             windowrulev2 = workspace special silent,$scratchpad
             windowrulev2 = center,$scratchpad

      # -- Kitty --
      windowrule=opacity 1,kitty
      windowrule=float,kitty_float
      windowrule=size 70% 70%,kitty_float
      windowrule=center,kitty_float

      # -- Neovide --
      windowrule=opacity 0.85,neovide
      windowrule=float,neovide
      windowrule=size 70% 70%,neovide
      windowrule=center,neovide

      # -- Spotify --
      windowrule=opacity 0.85,Spotify

      # -- Mpv --
      windowrule=size 70% 70%,mpv

      # -- Toolbox --
      windowrule=opacity 1,jetbrains-toolbox

      #-- Keybindings ----------------------------------------------------
      # Variables
      $term = ~/.config/hypr/scripts/terminal
      $launcher= ~/.config/hypr/rofi/bin/launcher
      $powermenu= ~/.config/hypr/rofi/bin/powermenu
      $volume = ~/.config/hypr/scripts/volume
      $backlight = ~/.config/hypr/scripts/brightness
      $screenshot = ~/.config/hypr/rofi/bin/screenshot
      $lockscreen = ~/.config/hypr/scripts/lockscreen
      $wlogout = ~/.config/hypr/scripts/wlogout
      $colorpicker = ~/.config/hypr/scripts/colorpicker
      $files = nautilus
      $editor = neovide
      $clipboard = cliphist list | rofi -dmenu -theme ~/.config/hypr/rofi/themes/mocha.rasi | cliphist decode | wl-copy
      $ide = jetbrains-toolbox
      $browser = firefox

      # -- Mouse --
      bindm=SUPER,mouse:272,movewindow
      bindm=SUPER,mouse:273,resizewindow

      # -- Terminal --
      bind=SUPERSHIFT,RETURN,exec,$term -f
      bind=SUPER,RETURN,exec,$term

      # -- Apps --
      bind=SUPERSHIFT,F,exec,$files
      bind=SUPER,R,exec,$lockscreen
      bind=SUPER,E,exec,$editor
      bind=SUPER,B,exec,$browser
      bind=SUPER,I,exec,$ide
      bind=SUPER,C,exec,vesktop
      bind=SUPER,M,exec,spotify --enable-features=UseOzonePlatform --ozone-platform=wayland
      bind=SUPER,O,exec,signal-desktop
      bind=SUPER,P,exec,prismlauncher

      # -- Rofi --
      bind=SUPER,D,exec,$launcher
      bind=SUPER,X,exec,$powermenu
      bind=SUPER,S,exec,$screenshot
      bind=SUPER,V,exec,$clipboard

      # -- Function keys --
      bind=,XF86MonBrightnessUp,exec,$backlight --inc
      bind=,XF86MonBrightnessDown,exec,$backlight --dec
      bind=,XF86AudioRaiseVolume,exec,$volume --inc
      bind=,XF86AudioLowerVolume,exec,$volume --dec
      bind=,XF86AudioMute,exec,$volume --toggle
      bind=,XF86AudioMicMute,exec,$volume --toggle-mic
      bind=,XF86AudioNext,exec,mpc next
      bind=,XF86AudioPrev,exec,mpc prev
      bind=,XF86AudioPlay,exec,mpc toggle
      bind=,XF86AudioStop,exec,mpc stop

      # -- Hyprland --
      bind=SUPER,Q,killactive,
      bind=CTRLALT,Delete,exit,
      bind=SUPER,F,fullscreen,
      bind=SUPER,Space,togglefloating,
      # bind=SUPER,P,pseudo,

      # Focus
      bind=SUPER,H,movefocus,l
      bind=SUPER,L,movefocus,r
      bind=SUPER,J,movefocus,u
      bind=SUPER,K,movefocus,d

      # Move
      bind=SUPERSHIFT,H,movewindow,l
      bind=SUPERSHIFT,L,movewindow,r
      bind=SUPERSHIFT,J,movewindow,u
      bind=SUPERSHIFT,K,movewindow,d

      # # -- Hyprland --
      # bind=SUPER,Q,killactive,
      # bind=CTRLALT,Delete,exit,
      # bind=SUPER,F,fullscreen,
      # bind=SUPER,Space,togglefloating,
      # bind=SUPER,P,pseudo,
      #
      # # Focus
      # bind=SUPER,H,movefocus,l
      # bind=SUPER,L,movefocus,r
      # bind=SUPER,J,movefocus,u
      # bind=SUPER,K,movefocus,d
      #
      # # Move
      # bind=SUPERSHIFT,H,movewindow,l
      # bind=SUPERSHIFT,L,movewindow,r
      # bind=SUPERSHIFT,J,movewindow,u
      # bind=SUPERSHIFT,K,movewindow,d

      # Resize
      bind=SUPERCTRL,left,resizeactive,-20 0
      bind=SUPERCTRL,right,resizeactive,20 0
      bind=SUPERCTRL,up,resizeactive,0 -20
      bind=SUPERCTRL,down,resizeactive,0 20

      # Switch workspaces with mainMod + [0-9]
      bind = $mainMod, 1, workspace, 1
      bind = $mainMod, 2, workspace, 2
      bind = $mainMod, 3, workspace, 3
      bind = $mainMod, 4, workspace, 4
      bind = $mainMod, 5, workspace, 5
      bind = $mainMod, 6, workspace, 6
      bind = $mainMod, 7, workspace, 7
      bind = $mainMod, 8, workspace, 8
      bind = $mainMod, 9, workspace, 9
      bind = $mainMod, 0, workspace, 10

      # Move active window to a workspace with mainMod + SHIFT + [0-9]
      bind = $mainMod SHIFT, 1, movetoworkspace, 1
      bind = $mainMod SHIFT, 2, movetoworkspace, 2
      bind = $mainMod SHIFT, 3, movetoworkspace, 3
      bind = $mainMod SHIFT, 4, movetoworkspace, 4
      bind = $mainMod SHIFT, 5, movetoworkspace, 5
      bind = $mainMod SHIFT, 6, movetoworkspace, 6
      bind = $mainMod SHIFT, 7, movetoworkspace, 7
      bind = $mainMod SHIFT, 8, movetoworkspace, 8
      bind = $mainMod SHIFT, 9, movetoworkspace, 9
      bind = $mainMod SHIFT, 0, movetoworkspace, 10

      # Send workspace to monitor
      bind=SUPERALT,0,movecurrentworkspacetomonitor, 0
      bind=SUPERALT,1,movecurrentworkspacetomonitor, 1

      # ROG G15 Strix (2021) Specific binds
      bind = ,156, exec, rog-control-center # ASUS Armory crate key
      bind = ,211, exec, asusctl profile -n; pkill -SIGRTMIN+8 waybar # Fan Profile key switch between power profiles
      bind = ,121, exec, pamixer -t # Speaker Mute FN+F1
      bind = ,122, exec, pamixer -d 5 # Volume lower key
      bind = ,123, exec, pamixer -i 5 # Volume Higher key
      bind = ,256, exec, pamixer --default-source -t # Mic mute key
      bind = ,232, exec, brightnessctl set 10%- # Screen brightness down FN+F7
      bind = ,233, exec, brightnessctl set 10%+ # Screen brightness up FN+F8
      bind = ,237, exec, brightnessctl -d asus::kbd_backlight set 33%- # Keyboard brightness down FN+F2
      bind = ,238, exec, brightnessctl -d asus::kbd_backlight set 33%+ # Keyboard brightnes up FN+F3
      bind = ,210, exec, asusctl led-mode -n # Switch keyboard RGB profile FN+F4

      bind = SUPER,N,exec,pypr toggle term && hyprctl dispatch bringactivetotop
      #-- Startup ----------------------------------------------------
      exec-once=~/.config/hypr/scripts/startup
      # exec-once=dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      # exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP
      exec-once = wl-paste --type text --watch cliphist store #Stores only text data
      exec-once = wl-paste --type image --watch cliphist store #Stores only image data
      # exec-once = swayidle -w timeout 300 '/home/philopater/.config/hypr/scripts/lockscreen' timeout 600 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
    '';
  };

  xdg.portal.configPackages = pkgs.xdg-desktop-portal-hyprland;

  home.packages = with pkgs; [
    swww
    grimblast
    cliphist
    hypridle
    hyprlock
    swaylock
    slurp
    swappy
    waybar
    rofi-wayland
    (pkgs.python3Packages.buildPythonPackage rec {
      pname = "pyprland";
      version = "1.4.1";
      src = pkgs.fetchPypi {
        inherit pname version;
        sha256 = "sha256-JRxUn4uibkl9tyOe68YuHuJKwtJS//Pmi16el5gL9n8=";
      };
      format = "pyproject";
      propagatedBuildInputs = with pkgs; [
        python3Packages.setuptools
        python3Packages.poetry-core
        poetry
      ];
      doCheck = false;
    })
  ];

  home.file.".config/hypr/pyprland.json".text = ''
    {
      "pyprland": {
        "plugins": ["scratchpads", "magnify"]
      },
      "scratchpads": {
        "term": {
          "command": "kitty --class scratchpad",
          "animation": "fromTop",
          "margin": 50
        }
      }
    }
  '';

  # You can also include other related configurations here, for example:
  # programs.hyprland = {
  #   enable = true;
  #   # Additional program-specific settings...
  # };
}
