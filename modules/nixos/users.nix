{ ... }:

{
  flake.modules.nixos.users = { pkgs, ... }: {
    users.users.xjle = {
      isNormalUser = true;
      description = "aditya";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "libvirtd" "docker" "networkmanager" ];
      packages = with pkgs; [
        tree
        obsidian
        bitwarden-desktop
      ];
    };
  };
}
