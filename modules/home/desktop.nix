{ config, inputs, ... }:

{
  flake.modules.homeManager.desktop = { pkgs, ... }: {
    imports = with config.flake.modules.homeManager; [
      niri-desktop
      wlogout-desktop
      kitty
      rofi
      opencode
      inir
      yazi-desktop
    ];

    home.packages = [
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.opencode2
      inputs.llm-agents.packages.${pkgs.stdenv.hostPlatform.system}.openclaw
      inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
      inputs.skwd-wall.packages.${pkgs.stdenv.hostPlatform.system}.plasma
      inputs.skwd-wall.packages.${pkgs.stdenv.hostPlatform.system}.default
      pkgs.wineWow64Packages.stable
      pkgs.wdisplays
      pkgs.winetricks
      pkgs.lutris
      pkgs.kitty
      pkgs.discord
      pkgs.winboat
    ];

    programs.fish.shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake .#desktop";
      opencode = "opencode2";
    };
  };
}
