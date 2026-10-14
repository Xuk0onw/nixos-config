{ pkgs, inputs, device, ... }:

{
  home.username = "xjle";
  home.homeDirectory = "/home/xjle";
  home.stateVersion = "26.11";
  programs.home-manager.enable = true;

  imports = [
    inputs.zen-browser.homeModules.beta
    ./home-manager/fish.nix
    ./home-manager/noctalia.nix
    ./home-manager/tmux.nix
    ./home-manager/wlogout.nix
    ./home-manager/btop.nix
    ./home-manager/niri.nix
    ./home-manager/mango.nix
    ./home-manager/nixvim.nix
    ./home-manager/bash.nix
    ./home-manager/cava.nix
    ./home-manager/fastfetch.nix
    ./home-manager/home-programs.nix
    ./home-manager/home-services.nix
    ./home-manager/gtk-qt.nix
    ./home-manager/river.nix
  ] ++ (if device == "thinkpad" then [
    ./home-manager/foot.nix
    ./home-manager/fuzzel.nix
  ] else [
    ./home-manager/kitty.nix
    ./home-manager/rofi.nix
  ]);

  home.packages = with pkgs; [
    wlogout
    cloudflare-warp
    vista-fonts
    qt6.qt5compat
    xdg-desktop-portal-gtk
    google-fonts
    corefonts
    inter
    snapshot
    gtk3
    nemo
    gimp
    qt6.qtsvg
    vlc
    obsidian
    zed-editor
    libreoffice-stable
    qalculate-gtk
    openlogi
    vscodium
  ] ++ (if device == "thinkpad" then [
    foot
    fuzzel
    firefox
  ] else [
    wineWow64Packages.stable
    inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.skwd-wall.packages.${pkgs.system}.default
    wdisplays
    pcsx2
    winetricks
    kitty
    heroic
    discord
    lutris
    winboat
  ]);

  home.sessionVariables = {
  QMLLS_BUILD_DIRS = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml";
  QML_IMPORT_PATH = "${pkgs.qt6.qtdeclarative}/lib/qt-6/qml:${pkgs.quickshell}/lib/qt-6/qml:${pkgs.qt6.qt5compat}/lib/qt-6/qml";
  FREETYPE_PROPERTIES = "cff:no-stem-darkening=0 autofitter:no-stem-darkening=0";
  GTK_THEME = "Orchis-Purple-Dark";
  ICON_THEME = "Tela-circle-dark";
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
}
