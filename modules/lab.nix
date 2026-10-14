{ pkgs, ... }:

{
  # VirtualBox
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "xjle" ];

  # WinBox
  programs.winbox = {
    enable = true;
    openFirewall = true;
  };

  # GNS3
  environment.systemPackages = with pkgs; [
    gns3-gui
    gns3-server
  ];
}
