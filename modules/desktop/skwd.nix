
{ inputs, pkgs, ... }:

let
  skwd-wall =
    inputs.skwd-wall.programs.${pkgs.stdenv.hostPlatform.system}.default;

  skwd-paper-plasma =
    inputs.skwd-wall.programs.${pkgs.stdenv.hostPlatform.system}.skwd-paper-plasma;
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
