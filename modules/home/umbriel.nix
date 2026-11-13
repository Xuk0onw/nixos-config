{ inputs, ... }:

{
  flake.modules.homeManager.umbriel = { ... }:


  {
    imports = [
      inputs.umbriel.homeModules.default
    ];

    programs.umbriel = {
      enable = true;
    };
  };
}
