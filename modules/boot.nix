{ lib, pkgs, hw_file, inputs, ... }:

{
  boot = {
    loader = {
      limine = {
        enable = true;
        maxGenerations = 10;

        style = {
          wallpapers = [ ];

          interface = {
            resolution = "2560x1600";
            brandingColor = "FFFFFF";
            helpColor = "FFFFFF";
            helpColorBright = "FFFFFF";
          };
          graphicalTerminal = {
            background = "FF000000";
            foreground = "FFFFFF";
            brightBackground = "FF000000";
            brightForeground = "FFFFFF";
          };
        };

        extraEntries = ''
      /Windows 11
      comment: Windows Boot Manager
      protocol: efi
      path: boot():/EFI/Microsoft/Boot/bootmgfw.efi'';
      };
      efi.canTouchEfiVariables = true;
    };

    consoleLogLevel = 0;

    initrd = {
      verbose = false;
      systemd.enable = true;
      kernelModules = [
        "amdgpu"
      ];
    };

    plymouth = {
      enable = true;
      theme = "mac-style";
      themePackages = [
        inputs.mac-style-plymouth.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

    kernelParams = [
      "quiet"
      "splash"
      "loglevel=3"
      "rd.systemd.show_status=false"
      "rd.udev.log_level=3"
      "udev.log_priority=3"
      "vt.global_cursor_default=0"
      "fbcon=nodefer"
    ] ++ lib.optionals (hw_file == "nixos") [
      "amdgpu.dcdebugmask=0x10"
    ];
  };

  environment.systemPackages = with pkgs; [
    plymouth
    sbctl
  ];
}
