{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;
    systemd.enable = true;

    settings = {
      backdrop = {
        enabled = false;
        blur_intensity = 0.0;
      };
    };
  };
}
