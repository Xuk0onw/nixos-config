{ lib, hw_file, ... }:

{
  services.xserver.wacom.enable = lib.mkIf (hw_file == "nixos") false;
  hardware.opentabletdriver.enable = lib.mkIf (hw_file == "nixos") false;
  hardware.uinput.enable = false;
  boot.kernelModules = [ "uinput" ];
}
