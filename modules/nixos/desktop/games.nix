{ ... }:

{
  flake.modules.nixos.games = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      steamcmd
      pcsx2
      heroic
      itch
      protonplus
    ];

    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      gamescopeSession.enable = true;

      extraPackages = with pkgs; [
        bibata-cursors
      ];
    };

    programs.gamemode.enable = true;
  };
}
