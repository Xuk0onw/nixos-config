{
  description = "Xjle NixOS";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    qylock.url = "github:Darkkal44/qylock";
    nix-cachyos-kernel.url ="github:xddxdd/nix-cachyos-kernel/release";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    skwd-wall.url = "github:liixini/skwd-wall";

    home-manager = {
      url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-style-plymouth = {
      url = "github:SergioRibera/s4rchiso-plymouth-theme";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
        inputs = {
          nixpkgs.follows = "nixpkgs";
            home-manager.follows = "home-manager";
      };
    };
    nixvim = {
      url = "github:nix-community/nixvim";
    };
    mangowm = {
      url = "github:mangowm/mango";
        inputs.nixpkgs.follows = "nixpkgs";
      };
      helium = {
        url = "github:schembriaiden/helium-browser-nix-flake";
          inputs.nixpkgs.follows = "nixpkgs";
      };
    };

  outputs = { self, nixpkgs, nixvim, home-manager, mangowm, noctalia, qylock,  ... }@inputs: {
    nixosConfigurations = {

      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; hw_file = "nixos"; };
        modules = [
         ./configuration.nix
         ./modules/desktop/noctalia.nix
         ./modules/desktop/cachykernel.nix
         #./modules/desktop/skwd.nix
          home-manager.nixosModules.home-manager
          mangowm.nixosModules.mango
          inputs.qylock.nixosModules.default
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xjle = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; device = "nixos"; };
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ inputs.nixvim.homeModules.nixvim ];
          }
        ];
      };

      thinkpad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; hw_file = "thinkpad"; };
        modules = [
          ./configuration.nix
          ({ pkgs, ... }: {
            boot.kernelPackages = pkgs.linuxPackages_xanmod;
          })
          home-manager.nixosModules.home-manager
          nixvim.nixosModules.nixvim
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.xjle = import ./home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; device = "thinkpad"; };
            home-manager.backupFileExtension = "backup";
            home-manager.sharedModules = [ inputs.nixvim.homeManagerModules.nixvim ];
          }
        ];
      };
    };
  };
}
