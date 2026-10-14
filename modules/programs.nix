{ lib, pkgs, hw_file, ... }:

{
  environment.systemPackages = with pkgs; [
    wget
    kdePackages.kdeconnect-kde
    speedtest-cli
    xwayland-satellite
    acpi
    plymouth
    bibata-cursors
    glib
    sshfs
    showmethekey
    tmux
    brightnessctl
    btop
    fastfetch
    libnotify
    python3
    bluez-tools
    playerctl
    cava
    cmatrix
    ffmpeg
    unzip
    unrar
    p7zip
    yazi
    typst
    texliveFull
    ddgr
    ripgrep
    fzf
    fd
    zoxide
    bat
    eza
    rmpc
    mpd
    mpc
    grim
    slurp
    fetch
    nil
    nixd
    yt-dlp
    jq
    eslint
    age
    sops
    gh
    steamcmd
  ] ++ lib.optionals (hw_file == "nixos") [
    opentabletdriver
    mangohud
    protonup-qt
    efibootmgr
    rofi
    alsa-utils
  ];

  programs.niri.enable = true;
  programs.hyprland.enable = false;
  programs.fish.enable = true;
  programs.mtr.enable = true;
  programs.kdeconnect.enable = true;
  programs.dconf.enable = true;
  programs.bash.enable = true;
  programs.mango.enable = false;
  programs.river-classic.enable = false;
  programs.nix-ld.enable = true;
}
