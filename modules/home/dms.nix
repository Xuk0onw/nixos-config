{ inputs, ... }:

{
  flake.modules.homeManager.dms = { lib, config, ... }:


  {
    imports = [
      inputs.dms.homeModules.dank-material-shell
      inputs.mangowm.hmModules.mango
    ];

    wayland.windowManager.mango = {
      enable = true;
      systemd.enable = true;
    };

    programs.dank-material-shell = {
      enable = lib.mkIf config.wayland.windowManager.mango.enable true;
      systemd.enable = true;
      systemd.target = "mango-session.target";
    };
  };
}
