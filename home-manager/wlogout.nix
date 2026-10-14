{ pkgs, device, ... }:

let
  isLowEnd = device == "thinkpad";

  iconSize = if isLowEnd then "64px" else "96px";

  buttonSize = if isLowEnd then "110px" else "180px";

  bgPos = if isLowEnd then "25px" else "40px";
in
{
  xdg.configFile."wlogout/layout".text = ''
    {
        "label" : "lock",
        "action" : "loginctl lock-session",
        "text" : "Lock",
        "keybind" : "l"
    }
    {
        "label" : "logout",
        "action" : "loginctl terminate-user $USER",
        "text" : "Logout",
        "keybind" : "e"
    }
    {
        "label" : "suspend",
        "action" : "systemctl suspend",
        "text" : "Suspend",
        "keybind" : "u"
    }
    {
        "label" : "hibernate",
        "action" : "systemctl hibernate",
        "text" : "Hibernate",
        "keybind" : "h"
    }
    {
        "label" : "shutdown",
        "action" : "systemctl poweroff",
        "text" : "Shutdown",
        "keybind" : "s"
    }
    {
        "label" : "reboot",
        "action" : "systemctl reboot",
        "text" : "Reboot",
        "keybind" : "r"
    }
  '';

  xdg.configFile."wlogout/style.css".text = ''
    * {
      background-image: none;
      font-family: "Hurmit Nerd Font";
      font-size: 13px;
    }

    window {
      background-color: rgba(46, 52, 64, 0.80);
    }

    button {
      color: #D8DEE9;
      background-color: #3B4252;
      border: 2px solid #4C566A;
      background-repeat: no-repeat;

      background-position: center ${bgPos};
      background-size: ${iconSize};

      min-height: ${buttonSize};
      min-width: ${buttonSize};

      border-radius: 12px;
      margin: 5px;
      padding: 0px;
      transition: background-color 0.2s, border-color 0.2s;
    }

    button:focus, button:active, button:hover {
      background-color: #434C5E;
      border-color: #88C0D0;
      color: #88C0D0;
    }

    #lock {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/lock.png");
    }

    #logout {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/logout.png");
    }

    #suspend {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/suspend.png");
    }

    #hibernate {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/hibernate.png");
    }

    #shutdown {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/shutdown.png");
    }

    #reboot {
      background-image: url("${pkgs.wlogout}/share/wlogout/icons/reboot.png");
    }
  '';
}
