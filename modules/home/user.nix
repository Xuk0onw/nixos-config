{ inputs, ... }:

{
  flake.modules.homeManager.user = { pkgs, ... }: {
    home.username = "xjle";
    home.homeDirectory = "/home/xjle";
    home.stateVersion = "26.11";
    programs.home-manager.enable = true;

    imports = [
      inputs.zen-browser.homeModules.beta
    ];

    home.packages = with pkgs; [
      wlogout
      cloudflare-warp
      vista-fonts
      qt6.qt5compat
      xdg-desktop-portal-gtk
      corefonts
      inter
      snapshot
      gtk3
      nemo
      gimp
      qt6.qtsvg
      vlc
      zed-editor
      (writeShellScriptBin "playwright" ''
        export PLAYWRIGHT_BROWSERS_PATH=${playwright-driver.browsers}
        export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
        export PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS=1
        exec ${playwright-test}/bin/playwright "$@"
      '')
      libreoffice-stable
      qalculate-gtk
      vscodium
      tuios
    ];

    home.sessionVariables = {
      QMLLS_BUILD_DIRS = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
      QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml";
      FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
      GTK_THEME = "Orchis-Purple-Dark";
      ICON_THEME = "Tela-circle-dark";
      # Use nixpkgs' patched browsers instead of downloading Playwright's own.
      PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
      PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
      PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "1";
    };

    xdg.configFile."fontconfig/fonts.conf".text = ''
      <?xml version='1.0'?>
      <!DOCTYPE fontconfig SYSTEM 'fonts.dtd'>
      <fontconfig>
       <match target="font">
        <edit mode="assign" name="hinting">
         <bool>false</bool>
        </edit>
       </match>

       <match target="font">
        <edit mode="assign" name="hintstyle">
         <const>hintslight</const>
        </edit>
       </match>

       <match target="font">
        <edit mode="assign" name="rgba">
         <const>rgb</const>
        </edit>
       </match>
       <match target="font">
        <edit mode="assign" name="antialias">
         <bool>true</bool>
        </edit>
       </match>
       <match target="font">
        <edit mode="assign" name="lcdfilter">
         <const>lcddefault</const>
        </edit>
       </match>
      </fontconfig>
    '';
  };
}
