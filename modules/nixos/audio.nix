{ ... }:

{
  flake.modules.nixos.audio = { pkgs, ... }: {
    environment.systemPackages = with pkgs; [
      pulseaudio
    ];

    hardware.alsa.enablePersistence = true;

    services.pipewire.alsa.support32Bit = true;

    systemd.user.services.enable-internal-mic = {
      description = "Enable internal microphone capture";

      after = [ "wireplumber.service" ];
      wants = [ "wireplumber.service" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.pulseaudio}/bin/pactl set-source-mute @DEFAULT_SOURCE@ 0";
        RemainAfterExit = true;
      };

      wantedBy = [ "default.target" ];
    };
  };
}
