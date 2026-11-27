{ inputs, ... }:

let
  mkUmbriel = { terminal, scale, desktopBinds }: { ... }:

  {
    imports = [
      inputs.umbriel.homeModules.default
    ];

    programs.umbriel = {
      enable = true;
      settings = ./config/umbriel/config.toml;
    };

    # iNiR's user-owned settings file; the 10-80 files and noctalia.toml stay runtime-managed
    xdg.configFile."umbriel/config.d/90-user-extra.toml".text =
      builtins.replaceStrings
        [ "@TERMINAL@" "@SCALE@" "@QUICKSHELL_BIND@" "@ROFI_BIND@" ]
        [
          terminal
          (toString scale)
          (if desktopBinds then ''"Ctrl+Space" = "spawn qs ipc call launcher open"'' else "")
          (if desktopBinds then ''"Mod+D" = "spawn sh -c 'pkill -x rofi || ~/.config/rofi/launchers/type-6/launcher.sh'"'' else "")
        ]
        (builtins.readFile ./config/umbriel/90-user-extra.toml);
  };
in
{
  flake.modules.homeManager.umbriel-desktop = mkUmbriel {
    terminal = "kitty";
    scale = 1.25;
    desktopBinds = true;
  };

  flake.modules.homeManager.umbriel-thinkpad = mkUmbriel {
    terminal = "foot";
    scale = 1.0;
    desktopBinds = false;
  };
}
