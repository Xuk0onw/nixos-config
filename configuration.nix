{ lib, pkgs, hw_file, ... }:

{
  nixpkgs.config.allowUnfree = true;
  boot.kernelPackages =
  if hw_file == "thinkpad" then
    pkgs.linuxPackages_libre
  else
    pkgs.linuxPackages;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  imports =
  [
    ./devices/${hw_file}.nix
    ./modules/boot.nix
    ./modules/variables.nix
    ./modules/programs.nix
    ./modules/services.nix
    ./modules/users.nix
    ./modules/wallpaperengine.nix
    ./modules/bluetooth.nix
    ./modules/font.nix
    ./modules/network.nix
    ./modules/optimisation.nix
    ./modules/audio.nix
    #./modules/lab.nix
    ./modules/olama.nix
    ./modules/git.nix
  ]
  ++ lib.optionals (hw_file != "thinkpad") [
    ./modules/desktop/nvidia.nix
    ./modules/desktop/games.nix
    ./modules/desktop/tablet.nix
    ./modules/obs.nix
  ];

  powerManagement = {
  enable = true;
  cpuFreqGovernor = "schedutil";
};
  zramSwap = {
  enable = true;
  algorithm = "zstd";
  memoryPercent = 50;
};
  services.tlp = {
    enable = true;

  settings = {
    STOP_CHARGE_THRESH_BAT0 = 1;
    PLATFORM_PROFILE_ON_AC   = "balanced";
    PLATFORM_PROFILE_ON_BAT  = "low-power";
    CPU_BOOST_ON_AC  = 0;
    CPU_BOOST_ON_BAT = 0;
    CPU_ENERGY_PERF_POLICY_ON_AC  = "balance_power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
    };
  };

  networking.hostName = hw_file;
  networking.networkmanager.enable = true;
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 53317 ];
    allowedUDPPorts = [ 53317 ];
  };
  systemd.services.NetworkManager-wait-online.enable = false;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };

  time.timeZone = "Asia/Jakarta";

  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id.indexOf("org.freedesktop.NetworkManager.") == 0 && subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';

  virtualisation.docker = {
    enable = true;
    enableOnBoot = false;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
    "id_ID.UTF-8/UTF-8"
  ];

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia
      kdePackages.qtsvg
      kdePackages.qt5compat
    ];
  };

  programs.qylock = {
    enable = true;
    theme = "nier-automata";
    sddm.enable = true;
  };

  system.stateVersion = "26.11";
}
