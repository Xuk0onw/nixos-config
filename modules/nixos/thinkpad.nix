{ config, inputs, ... }:

{
  flake.modules.nixos.thinkpad = { lib, pkgs, ... }: {
    imports = (with config.flake.modules.nixos; [
      common
      hardware-thinkpad
    ]) ++ [
      inputs.nixvim.nixosModules.nixvim
    ];

    networking.hostName = "thinkpad";
    boot.kernelPackages = pkgs.linuxPackages_xanmod;
    # devices/thinkpad.nix generates an invalid empty swap device
    swapDevices = lib.mkForce [ ];

    home-manager.users.xjle.imports = [ config.flake.modules.homeManager.thinkpad ];
  };
}
