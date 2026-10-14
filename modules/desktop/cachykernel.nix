{ inputs, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = lib.mkForce
    pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;
}
