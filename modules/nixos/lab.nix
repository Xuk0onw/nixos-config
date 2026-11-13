{ ... }:

{
  flake.modules.nixos.lab = { pkgs, ... }: {
    virtualisation.virtualbox.host.enable = true;
    users.extraGroups.vboxusers.members = [ "xjle" ];

    programs.winbox = {
      enable = true;
      openFirewall = true;
    };

    environment.systemPackages = with pkgs; [
      gns3-gui
      gns3-server
    ];
  };
}
