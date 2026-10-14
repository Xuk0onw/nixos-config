{
  programs.kitty = {
    enable = true;

    shellIntegration.enableZshIntegration = false;
    shellIntegration.enableFishIntegration = false;

    font = {
      name = "Hurmit Nerd Font";
      size = 13;
    };

    settings = {
      # --- General Settings ---
      background_opacity = "0.55";
      window_padding_width = 8;
      cursor_blink_interval = 0;
      tab_bar_style = "powerline";
      tab_powerline_style = "slanted";
      scrollback_lines = 10000;
      enable_audio_bell = "no";
      confirm_os_window_close = 0;

      # --- Theme ---
      background = "#1C1C1C";
      foreground = "#E5E5E5";
      selection_background = "#B8B8B8";
      selection_foreground = "#1C1C1C";
      url_color = "#D0D0D0";
      cursor = "#E0E0E0";
      cursor_text_color = "#1C1C1C";
      active_border_color = "#C0C0C0";
      inactive_border_color = "#555555";
      bell_border_color = "#D0D0D0";
      active_tab_background = "#A8A8A8";
      active_tab_foreground = "#1C1C1C";
      inactive_tab_background = "#303030";
      inactive_tab_foreground = "#C0C0C0";

      # --- Terminal Colors ---
      color0  = "#1A2333";
      color8  = "#50627A";
      color1  = "#FF9AA2";
      color9  = "#FFB3BA";
      color2  = "#A8E6CF";
      color10 = "#C8FACC";
      color3  = "#FFE29A";
      color11 = "#FFF0B3";
      color4  = "#8FBCFF";
      color12 = "#B4D4FF";
      color5  = "#C7B8FF";
      color13 = "#D8CCFF";
      color6  = "#9BE7FF";
      color14 = "#C9F3FF";
      color7  = "#DDE7F5";
      color15 = "#FFFFFF";
      cursor_shape = "block";
      shell_integration = "no-cursor";
    };
  };
}
