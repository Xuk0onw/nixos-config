{ ... }:

{
  flake.modules.nixos.wallpaperengine = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      linux-wallpaperengine
      kdePackages.wallpaper-engine-plugin

      mesa
      vulkan-loader
      vulkan-tools

      mpv
      ffmpeg

      (python3.withPackages (ps: with ps; [
        websockets
      ]))
    ];
  };
}
