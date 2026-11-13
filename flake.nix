{
  description = "Xjle NixOS";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    qylock.url = "github:Darkkal44/qylock";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    skwd-wall.url = "github:liixini/skwd-wall";
    llm-agents.url = "github:numtide/llm-agents.nix";
    umbriel.url = "github:noctalia-dev/umbriel";
    flake-parts.url = "github:hercules-ci/flake-parts";

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
    dms = {
      url = "github:duxlabs-dev/dux-shell/stable";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      flake.nixosConfigurations =
        let
          inherit (inputs) nixpkgs home-manager;

          mkHost = { hwFile, extraModules ? [ ] }: nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            specialArgs = { inherit inputs; hw_file = hwFile; };
            modules = [
              ./configuration.nix
              home-manager.nixosModules.home-manager
              inputs.qylock.nixosModules.default
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.xjle = import ./home.nix;
                home-manager.extraSpecialArgs = { inherit inputs; device = hwFile; };
                home-manager.backupFileExtension = "backup";
                home-manager.sharedModules = [ inputs.nixvim.homeModules.nixvim ];
              }
            ] ++ extraModules;
          };
        in
        {
          desktop = mkHost {
            hwFile = "nixos";
            extraModules = [
              ./modules/desktop/noctalia.nix
              ./modules/desktop/cachykernel.nix
              ./modules/desktop/umbriel.nix
              inputs.umbriel.nixosModules.default
              inputs.mangowm.nixosModules.mango
            ];
          };

          thinkpad = mkHost {
            hwFile = "thinkpad";
            extraModules = [
              inputs.nixvim.nixosModules.nixvim
            ];
          };
        };
    };
}
