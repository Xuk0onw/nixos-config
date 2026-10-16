
{ inputs, pkgs, ... }:

let
  skwd-wall =
    inputs.skwd-wall.packages.${pkgs.stdenv.hostPlatform.system}.default;

  skwd-paper-plasma =
    inputs.skwd-wall.packages.${pkgs.stdenv.hostPlatform.system}.plasma;
in
{
  imports = [
    inputs.skwd-wall.nixosModules.default
  ];

  environment.systemPackages = [
    skwd-wall
    skwd-paper-plasma
  ];

  services.skwd-deck = {
    enable = true;

    extraPackages = [
      skwd-paper-plasma
    ];
  };
}
