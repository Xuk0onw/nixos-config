{ pkgs, ... }:

{
  fonts.packages = with pkgs; [
    nerd-fonts.hurmit
    nerd-fonts.jetbrains-mono
    jetbrains-mono
    nerd-fonts.iosevka
    nerd-fonts.iosevka-term
    nerd-fonts.iosevka-term-slab
    vista-fonts
    google-fonts
    corefonts
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-color-emoji
    dejavu_fonts
    liberation_ttf
    fira-code
    font-awesome
    fontconfig
  ];
}
