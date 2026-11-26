{ ... }:

{
  flake.modules.homeManager.yazi = { ... }: {
    programs.yazi = {
      enable = true;
      settings.mgr = {
        sort_by = "natural";
        sort_dir_first = true;
        show_hidden = true;
        linemode = "size";
      };
      keymap.mgr.prepend_keymap = [
        {
          on = [ "g" "d" ];
          run = "cd ~/Downloads";
          desc = "Go to Downloads";
        }
      ];
    };
  };
}
