{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  hardware.alsa.enablePersistence = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };

  systemd.user.services.enable-internal-mic = {
    description = "Enable internal microphone capture";

    after = [ "wireplumber.service" ];
    wants = [ "wireplumber.service" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.alsa-utils}/bin/amixer -c Generic_1 sset Capture cap";
      RemainAfterExit = true;
    };

    wantedBy = [ "default.target" ];
  };
}
