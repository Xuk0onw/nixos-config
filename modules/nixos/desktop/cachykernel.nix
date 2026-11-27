{ inputs, ... }:

{
  flake.modules.nixos.cachykernel = { lib, pkgs, ... }: {
    nixpkgs.overlays = [
      inputs.nix-cachyos-kernel.overlays.pinned
    ];

    boot.kernelPackages = lib.mkForce
      pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-zen4;

    nix.settings = {
      extra-substituters = [
        "https://cache.lantian.pub/lantian"
      ];

      extra-trusted-public-keys = [
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
      ];
    };
  };
}
