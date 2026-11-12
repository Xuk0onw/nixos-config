{ lib, ... }:

{
  programs.inir = {
    enable = true;
    desktop.enable = false;
    niriConfig.seed = false;
    service.compositor = null;
  };

  users.users.xjle.extraGroups = [ "video" "input" ];

  systemd.user.services.inir = {
    wantedBy = [ "umbriel.service" ];
    partOf = lib.mkForce [ "umbriel.service" ];
    after = lib.mkForce [ "umbriel.service" ];
    unitConfig.Requisite = lib.mkForce "umbriel.service";
  };
}
