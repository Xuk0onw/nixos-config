{ ... }:

{
  flake.modules.nixos.users = { pkgs, ... }: {
    users.users.xjle = {
      isNormalUser = true;
      description = "aditya";
      shell = pkgs.fish;
      extraGroups = [ "wheel" "libvirtd" "networkmanager" ];
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEVLlATJ4fGYd4LyhQ6K7CK9n3sHZpJ7Vpln3Wf+YV11 github"
      ];
      packages = with pkgs; [
        tree
        obsidian
        bitwarden-desktop
      ];
    };
  };
}
