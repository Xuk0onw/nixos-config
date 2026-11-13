{ ... }:

let
  mkNiri = { terminal, scale }: { pkgs, ... }:
    let
      rawConfig = builtins.readFile ./config/niri.kdl;
      finalConfig = builtins.replaceStrings [ "@TERMINAL@" ] [ terminal ] rawConfig;
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
    scale = "1.25";
  };

  flake.modules.homeManager.niri-thinkpad = mkNiri {
    terminal = "foot";
    scale = "1.0";
  };
}
