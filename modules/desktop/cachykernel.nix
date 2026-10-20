{ inputs, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = lib.mkForce
    pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

  nix.settings = {
    substituters = [
      "https://cache.xinux.uz"
    ];

    trusted-public-keys = [
      "cache.xinux.uz:BXCrtqejFjWzWEB9YuGB7X2MV4ttBur1N8BkwQRdH+0="
    ];
  };
}
