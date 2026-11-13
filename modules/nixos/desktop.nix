{ config, inputs, ... }:

{
  flake.modules.nixos.desktop = { pkgs, ... }: {
    imports = (with config.flake.modules.nixos; [
      common
      hardware-desktop
      nvidia
      games
      tablet
      cachykernel
      noctalia
      umbriel
      obs
      ollama
    ]) ++ [
      inputs.umbriel.nixosModules.default
      inputs.mangowm.nixosModules.mango
    ];

    networking.hostName = "nixos";
    boot.kernelPackages = pkgs.linuxPackages_zen;
    boot.kernelParams = [ "amdgpu.dcdebugmask=0x10" ];

    environment.systemPackages = with pkgs; [
      opentabletdriver
      mangohud
      efibootmgr
      rofi
      alsa-utils
    ];

    home-manager.users.xjle.imports = [ config.flake.modules.homeManager.desktop ];
  };
}
