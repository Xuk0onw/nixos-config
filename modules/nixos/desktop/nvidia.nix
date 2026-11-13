{ ... }:

{
  flake.modules.nixos.nvidia = { config, ... }: {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
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
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
    };
  };
}
