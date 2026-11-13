{ ... }:

{
  flake.modules.nixos.tablet = {
    services.xserver.wacom.enable = false;
    hardware.opentabletdriver.enable = false;
    hardware.uinput.enable = false;
    boot.kernelModules = [ "uinput" ];
  };
}
