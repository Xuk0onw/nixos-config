{ pkgs, ... }:

let
  layout = "wideriver";

  screenarea =
    "grimblast save area - | satty --filename -";

  screenactive =
    "grimblast save active - | satty --filename -";
in
{
  # ==========================================
  # Packages
  # ==========================================

  home.packages = with pkgs; [
    wideriver
    grimblast
    satty
    wl-clipboard
    wlr-randr
    cliphist
    brightnessctl
    playerctl
    swaylock
  ];

  # ==========================================
  # Cursor
  # ==========================================

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;

    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 22;

    x11 = {
      enable = true;
      defaultCursor = "Bibata-Modern-Classic";
    };
  };

  # ==========================================
  # River
  # ==========================================

  wayland.windowManager.river = {
    enable = true;
    xwayland.enable = true;

    settings = {
      # ========================================
      # Layout
      # ========================================

      default-layout = layout;
      output-layout = layout;

      border-width = 2;

      declare-mode = [
        "locked"
        "normal"
      ];

      # ========================================
      # Keybinds
      # ========================================

      map = {
        normal = {

          # ======================================
          # Terminal
          # ======================================

          "Super Return" =
            "spawn ${pkgs.kitty}/bin/kitty";

          # ======================================
          # Nemo
          # ======================================

          "Super E" =
            "spawn nemo";

          # ======================================
          # Walker
          # ======================================

          "Super D" =
            "spawn walker";

          # ======================================
          # Noctalia Launcher
          # ======================================

          "Control Space" =
            "spawn noctalia msg panel-toggle launcher";

          # ======================================
          # Noctalia Control Center
          # ======================================

          "Super+Shift C" =
            "spawn noctalia msg panel-toggle control-center";

          # ======================================
          # Close Window
          # ======================================

          "Super Q" =
            "close";

          # ======================================
          # Lock Screen
          # ======================================

          "Super+Alt L" =
            "spawn swaylock";

          # ======================================
          # Focus
          # ======================================

          "Super Left" =
            "focus-view left";

          "Super H" =
            "focus-view left";

          "Super Down" =
            "focus-view down";

          "Super J" =
            "focus-view down";

          "Super Up" =
            "focus-view up";

          "Super K" =
            "focus-view up";

          "Super Right" =
            "focus-view right";

          "Super L" =
            "focus-view right";

          # ======================================
          # Move Window
          # ======================================

          "Super+Control Left" =
            "move left 100";

          "Super+Control H" =
            "move left 100";

          "Super+Control Down" =
            "move down 100";

          "Super+Control J" =
            "move down 100";

          "Super+Control Up" =
            "move up 100";

          "Super+Control K" =
            "move up 100";

          "Super+Control Right" =
            "move right 100";

          "Super+Control L" =
            "move right 100";

          # ======================================
          # Resize
          # ======================================

          "Super+Alt+Shift H" =
            "resize horizontal -100";

          "Super+Alt+Shift J" =
            "resize vertical 100";

          "Super+Alt+Shift K" =
            "resize vertical -100";

          "Super+Alt+Shift L" =
            "resize horizontal 100";

          # ======================================
          # Tiling ↔ Wide / Scrolling
          #
          # Wideriver:
          # layout     = left
          # layout-alt = wide
          #
          # Super + R toggles between them.
          # ======================================

          "Super R" =
            ''send-layout-cmd ${layout} "--layout-toggle"'';

          # ======================================
          # Wideriver Ratio
          # ======================================

          "Super+Shift H" =
            ''send-layout-cmd ${layout} "ratio +0.05"'';

          "Super+Shift L" =
            ''send-layout-cmd ${layout} "ratio -0.05"'';

          # ======================================
          # Wideriver Master Count
          # ======================================

          "Super+Shift K" =
            ''send-layout-cmd ${layout} "count +1"'';

          "Super+Shift J" =
            ''send-layout-cmd ${layout} "count -1"'';

          # ======================================
          # Floating
          # ======================================

          "Super V" =
            "toggle-float";

          # ======================================
          # Fullscreen
          # ======================================

          "Super+Shift F" =
            "toggle-fullscreen";

          # ======================================
          # Screenshot Active Window
          # ======================================

          "Super+Shift S" =
            ''spawn "${screenactive}"'';

          # ======================================
          # Screenshot Area
          # ======================================

          "Super Print" =
            ''spawn "${screenarea}"'';

          # ======================================
          # Browser
          # ======================================

          "Super W" =
            "spawn zen-beta";

          "Super+Shift W" =
            "spawn helium";

          # ======================================
          # Steam
          # ======================================

          "Super S" =
            "spawn steam";

          # ======================================
          # Next / Previous View
          # ======================================

          "Super Tab" =
            "focus-view next";

          "Super+Shift Tab" =
            "focus-view previous";

          # ======================================
          # Exit River
          # ======================================

          "Super+Shift E" =
            "exit";

          "Control+Alt Delete" =
            "exit";

          # ======================================
          # Audio
          # ======================================

          "XF86AudioRaiseVolume" =
            "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+";

          "XF86AudioLowerVolume" =
            "spawn wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-";

          "XF86AudioMute" =
            "spawn wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";

          "XF86AudioMicMute" =
            "spawn wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

          # ======================================
          # Brightness
          # ======================================

          "XF86MonBrightnessUp" =
            "spawn brightnessctl --class=backlight set +10%";

          "XF86MonBrightnessDown" =
            "spawn brightnessctl --class=backlight set 10%-";
        };
      };

      # ==========================================
      # Startup
      # ==========================================

      spawn = [
        # Clipboard text
        "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store"

        # Clipboard images
        "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store"

        # Fcitx5
        "${pkgs.fcitx5}/bin/fcitx5 -d"

        # Noctalia v5
        "noctalia"
      ];

      # ==========================================
      # Cursor
      # ==========================================

      xcursor-theme = "Bibata-Modern-Classic";

      set-repeat = "50 300";

      focus-follows-cursor = "normal";

      # ==========================================
      # Mouse
      # ==========================================

      map-pointer = {
        normal = {
          "Super BTN_LEFT" =
            "move-view";

          "Super BTN_RIGHT" =
            "resize-view";
        };
      };
    };

    # ==========================================
    # Environment
    # ==========================================

    extraSessionVariables = {
      TERM = "kitty";

      QT_QPA_PLATFORM = "wayland";

      MOZ_ENABLE_WAYLAND = "1";

      XDG_CURRENT_DESKTOP = "river";

      XDG_SESSION_DESKTOP = "river";
    };

    # ==========================================
    # Startup
    # Scaling
    # Wideriver
    # Tags
    # ==========================================

    extraConfig = ''
      # ============================================
      # Display Scaling
      # ============================================

      wlr-randr \
        --output eDP-1 \
        --scale 1.25


      # ============================================
      # Start Wideriver
      # ============================================
      #
      # left = normal tiling
      # wide = wide / scrolling-like layout
      #

      ${pkgs.wideriver}/bin/wideriver \
        --layout left \
        --layout-alt wide \
        --inner-gaps 6 \
        --outer-gaps 6 &

      sleep 0.5

      riverctl default-layout wideriver


      # ============================================
      # Workspace / Tags 1-4
      # ============================================

      # Workspace 1
      riverctl map normal Super 1 \
        set-focused-tags $((1 << 0))

      riverctl map normal Super+Shift 1 \
        set-view-tags $((1 << 0))


      # Workspace 2
      riverctl map normal Super 2 \
        set-focused-tags $((1 << 1))

      riverctl map normal Super+Shift 2 \
        set-view-tags $((1 << 1))


      # Workspace 3
      riverctl map normal Super 3 \
        set-focused-tags $((1 << 2))

      riverctl map normal Super+Shift 3 \
        set-view-tags $((1 << 2))


      # Workspace 4
      riverctl map normal Super 4 \
        set-focused-tags $((1 << 3))

      riverctl map normal Super+Shift 4 \
        set-view-tags $((1 << 3))


      # ============================================
      # All Workspaces
      # ============================================

      all_tags=$(((1 << 4) - 1))

      riverctl map normal Super 0 \
        set-focused-tags $all_tags

      riverctl map normal Super+Shift 0 \
        set-view-tags $all_tags
    '';
  };
}
