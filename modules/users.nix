{ pkgs, ... }:

{
  users.users.xjle = {
    isNormalUser = true;
    description = "aditya";
    shell = pkgs.fish;
    extraGroups = [ "wheel" "libvirtd" "docker" "networkmanager" ];
    packages = with pkgs; [
      tree
      bitwarden-desktop
    ];
  };
}
