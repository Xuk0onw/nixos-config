{
  programs.fuzzel = {
    enable = false;

    settings = {
      main = {
        font = "Hurmit Nerd Font:size=16";
        terminal = "kitty";
        width = 55;
        horizontal-pad = 28;
        vertical-pad = 22;
        inner-pad = 18;
        lines = 14;
        layer = "overlay";
      };
      colors = {
        background = "11182766";
        text = "EAF2FFff";
        prompt = "8FBCFFff";
        placeholder = "B4D4FFaa";
        input = "EAF2FFff";
        match = "8FBCFFff";
        selection = "24324799";
        selection-text = "FFFFFFff";
        selection-match = "9BE7FFff";
        border = "8FBCFF99";
      };
    };
  };
}
