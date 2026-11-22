{ inputs, ... }:

{
  flake.modules.homeManager.umbriel = { ... }:


  {
    imports = [
      inputs.umbriel.homeModules.default
    ];

    programs.umbriel = {
      enable = true;
      settings = ./config/umbriel/config.toml;
    };

    # iNiR's user-owned settings file; the 10-80 files and noctalia.toml stay runtime-managed
    xdg.configFile."umbriel/config.d/90-user-extra.toml".source = ./config/umbriel/90-user-extra.toml;
  };
}
