{ config, inputs, ... }:

{
  flake.modules.nixos.home-manager = {
    imports = [ inputs.home-manager.nixosModules.home-manager ];

    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      backupFileExtension = "backup";
      sharedModules = [ inputs.nixvim.homeModules.nixvim ];
      users.xjle.imports = [ config.flake.modules.homeManager.base ];
    };
  };
}
