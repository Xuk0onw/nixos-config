{ ... }:

{
  flake.modules.homeManager.librewolf = { ... }: {
    xdg.configFile = {
      "librewolf/librewolf/2utbk0ck.default/chrome/userChrome.css".source = ./config/librewolf/userChrome.css;
      "librewolf/librewolf/2utbk0ck.default/chrome/userContent.css".source = ./config/librewolf/userContent.css;

      # defaultPref: user.js and prefs.js still win, iNiR's colour writes are untouched.
      "librewolf/librewolf/librewolf.overrides.cfg".text = ''
        defaultPref("toolkit.legacyUserProfileCustomizations.stylesheets", true);
      '';
    };
  };
}
