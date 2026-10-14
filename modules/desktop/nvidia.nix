{ config, lib, hw_file, ... }:

{
  services.xserver.videoDrivers =
    lib.mkIf (hw_file == "nixos") [ "nvidia" ];
  hardware.nvidia = lib.mkIf (hw_file == "nixos") {
    modesetting.enable = true;
    open = true;
    powerManagement.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      amdgpuBusId = "PCI:65:0:0";
      nvidiaBusId = "PCI:63:0:0";
    };
  };
  hardware.graphics = lib.mkIf (hw_file == "nixos") {
    enable = true;
    enable32Bit = true;
  };
}
