{ config, inputs, ... }:

{
  flake.modules.nixos.common = {
    imports = (with config.flake.modules.nixos; [
      boot
      variables
      programs
      services
      users
      docker
      bluetooth
      font
      network
      optimisation
      audio
      binary-caches
      git
      settings
      home-manager
    ]) ++ [
      inputs.qylock.nixosModules.default
    ];
  };
}
