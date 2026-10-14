{ ... }:

{
  programs = {
    bash.enable = true;
    zen-browser.enable = true;

    fzf.enable = true;

    zoxide = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
    };

    bat.enable = true;

    eza = {
      enable = true;
      enableFishIntegration = true;
      enableBashIntegration = true;
      icons = "auto";
      git = true;
    };
  };
}
