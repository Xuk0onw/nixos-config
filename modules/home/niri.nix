{ ... }:

let
  mkNiri = { terminal, terminalName, scale, desktopBinds }: { pkgs, ... }:
    let
      rawConfig = builtins.readFile ./config/niri.kdl;
      finalConfig = builtins.replaceStrings
        [ "@TERMINAL@" "@TERMINAL_NAME@" "@QUICKSHELL_BIND@" "@ROFI_BIND@" ]
        [
          terminal
          terminalName
          (if desktopBinds then ''
            Ctrl+Space hotkey-overlay-title="Quickshell Launcher" {
                spawn "qs" "ipc" "call" "launcher" "open";
            }
          '' else "")
          (if desktopBinds then ''
            Mod+D {
                spawn "sh" "-c" "pkill -x rofi || ~/.config/rofi/launchers/type-6/launcher.sh";
            }
          '' else "")
        ]
        rawConfig;
    in
    {
      xdg.configFile."niri/config.kdl".text = ''
        spawn-at-startup "bash" "-c" "${pkgs.tmux}/bin/tmux new-session -d -s warm-up; sleep 6; ${pkgs.tmux}/bin/tmux kill-session -t warm-up"

        output "eDP-1" {
            mode "2560x1600@165"
            scale ${scale}
        }

        ${finalConfig}
      '';
    };
in
{
  flake.modules.homeManager.niri-desktop = mkNiri {
    terminal = "kitty";
    terminalName = "kitty";
    scale = "1.25";
    desktopBinds = true;
  };

  flake.modules.homeManager.niri-thinkpad = mkNiri {
    terminal = "foot";
    terminalName = "foot";
    scale = "1.0";
    desktopBinds = false;
  };
}
