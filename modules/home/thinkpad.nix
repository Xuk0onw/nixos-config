{ config, ... }:

{
  flake.modules.homeManager.thinkpad = { pkgs, ... }: {
    imports = with config.flake.modules.homeManager; [
      niri-thinkpad
      wlogout-thinkpad
      foot
      fuzzel
    ];

    home.packages = with pkgs; [
      foot
      fuzzel
      firefox
    ];

    programs.fish.shellAliases.nrs = "sudo nixos-rebuild switch --flake .#thinkpad";
  };
}
