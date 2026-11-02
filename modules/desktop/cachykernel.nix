{ inputs, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  boot.kernelPackages = lib.mkForce
    pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

  nix.settings = {
    substituters = [
      "https://cache.lantian.pub/lantian"
    ];

    trusted-public-keys = [
      "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
    ];
  };
}
