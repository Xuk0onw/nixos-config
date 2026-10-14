{ ... }:

{
  programs.git = {
    enable = true;

    config = {
      user.name = "Xuk0onw";
      user.email = "aditberka@gmail.com";

      init.defaultBranch = "main";
      push.autoSetupRemote = true;
    };
  };
}
