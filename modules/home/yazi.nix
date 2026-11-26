{ ... }:

{
  flake.modules.homeManager.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [ ouch wl-clipboard ];
      settings = {
        mgr = {
          sort_by = "natural";
          sort_dir_first = true;
          show_hidden = true;
          linemode = "size";
        };
        plugin = {
          prepend_fetchers = [
            { url = "*"; run = "git"; group = "git"; }
            { url = "*/"; run = "git"; group = "git"; }
          ];
          prepend_previewers = [
            {
              mime = "application/{*zip,tar,bzip2,7z*,rar,xz,zstd,java-archive}";
              run = "ouch";
            }
          ];
        };
      };
      plugins = {
        git = {
          package = pkgs.yaziPlugins.git;
          setup = true;
          settings.order = 1500;
        };
        full-border = {
          package = pkgs.yaziPlugins.full-border;
          setup = true;
        };
        mime-ext = {
          package = pkgs.yaziPlugins.mime-ext;
          setup = true;
        };
        yatline = {
          package = pkgs.yaziPlugins.yatline;
          setup = true;
        };
        smart-filter = pkgs.yaziPlugins.smart-filter;
        jump-to-char = pkgs.yaziPlugins.jump-to-char;
        toggle-pane = pkgs.yaziPlugins.toggle-pane;
        ouch = pkgs.yaziPlugins.ouch;
        wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
        bypass = pkgs.yaziPlugins.bypass;
      };
      keymap.mgr.prepend_keymap = [
        {
          on = [ "g" "d" ];
          run = "cd ~/Downloads";
          desc = "Go to Downloads";
        }
        {
          on = "f";
          run = "plugin smart-filter";
          desc = "Smart filter";
        }
        {
          on = "F";
          run = "plugin jump-to-char";
          desc = "Jump to char";
        }
        {
          on = "T";
          run = "plugin toggle-pane max-preview";
          desc = "Maximize or restore preview";
        }
        {
          on = "C";
          run = "plugin ouch";
          desc = "Compress with ouch";
        }
        {
          on = [ "c" "w" ];
          run = "plugin wl-clipboard";
          desc = "Copy paths to Wayland clipboard";
        }
        {
          on = "<A-h>";
          run = "plugin bypass reverse";
          desc = "Skip up through single-subdir parents";
        }
        {
          on = "<A-l>";
          run = "plugin bypass";
          desc = "Skip down through single-subdir children";
        }
      ];
    };
  };
}
