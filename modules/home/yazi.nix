{ ... }:

{
  flake.modules.homeManager.yazi = { pkgs, ... }: {
    programs.yazi = {
      enable = true;
      extraPackages = with pkgs; [ ouch wl-clipboard ripdrag allmytoes ];
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
            { mime = "image/svg+xml"; run = "magick"; }
            { mime = "image/heic"; run = "magick"; }
            { mime = "image/jxl"; run = "magick"; }
            { mime = "image/*"; run = "allmytoes"; }
          ];
          prepend_preloaders = [
            { mime = "image/svg+xml"; run = "magick"; }
            { mime = "image/heic"; run = "magick"; }
            { mime = "image/jxl"; run = "magick"; }
            { mime = "image/*"; run = "allmytoes"; }
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
        contextmenu = {
          package = "${pkgs.fetchFromGitHub {
            owner = "lostofctrl";
            repo = "yazi-contextmenu";
            rev = "751e13800c434439f235d1de27dd666e5d44e767";
            hash = "sha256-G4Oj3S8dT9KUQcROuK3c1pkjIwhPzUJLIU7NJYOSgi0=";
          }}/contextmenu.yazi";
          setup = true;
        };
        smart-filter = pkgs.yaziPlugins.smart-filter;
        jump-to-char = pkgs.yaziPlugins.jump-to-char;
        toggle-pane = pkgs.yaziPlugins.toggle-pane;
        ouch = pkgs.yaziPlugins.ouch;
        wl-clipboard = pkgs.yaziPlugins.wl-clipboard;
        bypass = pkgs.yaziPlugins.bypass;
        smart-paste = pkgs.yaziPlugins.smart-paste;
        vcs-files = pkgs.yaziPlugins.vcs-files;
        chmod = pkgs.yaziPlugins.chmod;
        keep-preferences = {
          package = pkgs.yaziPlugins.keep-preferences;
          setup = true;
        };
        bookmarks = pkgs.yaziPlugins.bookmarks;
        easyjump = {
          package = pkgs.yaziPlugins.easyjump;
          setup = true;
        };
        mount = pkgs.yaziPlugins.mount;
        drag = pkgs.yaziPlugins.drag;
        allmytoes = {
          package = pkgs.yaziPlugins.allmytoes;
          setup = true;
        };
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
        {
          on = "p";
          run = "plugin smart-paste";
          desc = "Paste into hovered directory or CWD";
        }
        {
          on = [ "g" "v" ];
          run = "plugin vcs-files";
          desc = "Show Git file changes";
        }
        {
          on = [ "c" "m" ];
          run = "plugin chmod";
          desc = "Chmod selected files";
        }
        {
          on = [ "b" "m" ];
          run = "plugin bookmarks save";
          desc = "Save bookmark";
        }
        {
          on = "'";
          run = "plugin bookmarks jump";
          desc = "Jump to bookmark";
        }
        {
          on = [ "b" "d" ];
          run = "plugin bookmarks delete";
          desc = "Delete bookmark";
        }
        {
          on = [ "b" "D" ];
          run = "plugin bookmarks delete_all";
          desc = "Delete all bookmarks";
        }
        {
          on = "i";
          run = "plugin easyjump";
          desc = "Jump to a visible file";
        }
        {
          on = "M";
          run = "plugin mount";
          desc = "Mount manager";
        }
        {
          on = "<A-d>";
          run = "plugin drag";
          desc = "Drag selected files";
        }
      ];
    };
  };

  flake.modules.homeManager.yazi-desktop = {
    xdg = {
      enable = true;
      mimeApps = {
        enable = true;
        defaultApplications = {
          "inode/directory" = "yazi.desktop";
          "x-scheme-handler/file" = "yazi.desktop";
        };
      };
      desktopEntries.yazi = {
        name = "Yazi";
        genericName = "File Manager";
        comment = "Terminal file manager";
        exec = "kitty -e yazi %f";
        mimeType = [ "inode/directory" "x-scheme-handler/file" ];
        categories = [ "System" "FileManager" ];
        terminal = false;
      };
    };
  };
}
