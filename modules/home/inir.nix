{ inputs, lib, ... }:

{
  flake.modules.homeManager.inir = { config, ... }: {
    imports = [ inputs.inir.homeModules.default ];

    programs.inir = {
      enable = true;
      niriConfig.seed = false;
    };

    # DMS also pulls upstream quickshell; share iNiR's patched build so bin/qs does not collide
    programs.quickshell.package = lib.mkForce config.programs.inir.package.passthru.quickshell;

    # upstream home module hardcodes niri.service; iNiR belongs to the Umbriel session here
    systemd.user.services.inir = {
      Unit.PartOf = lib.mkForce [ "umbriel.service" ];
      Unit.After = lib.mkForce [ "umbriel.service" ];
      Install.WantedBy = lib.mkForce [ "umbriel.service" ];
    };
  };
}
