{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # Wallpaper Engine
    linux-wallpaperengine
    kdePackages.wallpaper-engine-plugin

    # Graphics
    mesa
    vulkan-loader
    vulkan-tools

    # Media
    mpv
    ffmpeg

    # Python + websockets
    (python3.withPackages (ps: with ps; [
      websockets
    ]))
  ];
}
