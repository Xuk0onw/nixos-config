{ ... }:

{
  nix.settings = {
    auto-optimise-store = true;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 8d";
  };

  nix.optimise = {
    automatic = true;
    dates = [ "weekly" ];
  };
}
