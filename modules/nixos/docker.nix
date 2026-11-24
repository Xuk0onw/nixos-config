{ ... }:

{
  flake.modules.nixos.docker = {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };

    users.users.xjle.extraGroups = [ "docker" ];
  };

  flake.modules.nixos.docker-nvidia = {
    hardware.nvidia-container-toolkit.enable = true;
    virtualisation.docker.daemon.settings.features.cdi = true;
  };
}
