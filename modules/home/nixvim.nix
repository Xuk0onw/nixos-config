{ ... }:

{
  flake.modules.homeManager.nixvim =
    { pkgs, config, ... }:

    {
      programs.nixvim = {
        enable = true;
        defaultEditor = true;
        viAlias = true;
        vimAlias = true;
        globals.mapleader = " ";
        globals.maplocalleader = " ";

        # use the system package set so unfree plugins (copilot) are allowed
        nixpkgs.useGlobalPackages = true;

        # craftzdog's lua utils (icons, lualine components, tabline, lazygit, editor helpers)
        extraFiles."lua/craftzdog".source = ./config/nvim/lua/craftzdog;

        extraPlugins = with pkgs.vimPlugins; [
          solarized-osaka-nvim
          lualine-nvim
          mini-icons
          mini-diff
          incline-nvim
          codediff-nvim
          live-preview-nvim
        ];

        extraConfigLuaPre = ''
          _G.Craftzdog = require("craftzdog.utils")
          vim.opt.iskeyword:append("-")
          vim.opt.path:append("**")
          vim.opt.wildignore:append({ "*/node_modules/*", "*.o", "*.obj", "*.pyc", "*.class", "*.jar" })
          vim.opt.fillchars:append("diff:╱")
        '';
        opts = {
          number = true;
          relativenumber = true;
          wrap = false;
          tabstop = 2;
          shiftwidth = 2;
          expandtab = true;
          smartindent = true;
          swapfile = false;
          guicursor = "";
          ignorecase = true;
          scrolloff = 10;
          winborder = "rounded";
          # craftzdog options
          cursorline = true;
          smartcase = true;
          signcolumn = "yes";
          showmatch = true;
          matchtime = 2;
          cmdheight = 0;
          completeopt = [
            "menuone"
            "noinsert"
            "noselect"
          ];
          pumheight = 10;
          pumblend = 10;
          laststatus = 3;
          undofile = true;
          undodir = "~/.cache/nvim/undodir";
          updatetime = 300;
          timeoutlen = 500;
          sidescrolloff = 8;
          clipboard = "unnamedplus";
          mouse = "";
          foldmethod = "expr";
          foldexpr = "v:lua.vim.treesitter.foldexpr()";
          foldlevel = 99;
          splitbelow = true;
          splitright = true;
          title = true;
        };

        extraPackages = with pkgs; [
          tree-sitter
          git
          curl
          jq
          sqlite
          ripgrep
          fd
          gcc
          nixpkgs-fmt
          kdePackages.qtdeclarative
          kdlfmt
          typst
          tinymist
          texliveFull
          zathura
          lazygit
          oxfmt
          prettierd
          stylua
          shfmt
          bash-language-server
          pyright
        ];

        autoCmd = [
          {
            event = "BufWritePost";
            pattern = "*.kdl";
            command = "!kdlfmt -i %";
          }
          # craftzdog autocmds
          {
            event = "InsertLeave";
            pattern = "*";
            command = "set nopaste";
          }
          {
            event = [
              "VimEnter"
              "WinEnter"
              "BufWinEnter"
            ];
            pattern = "*";
            command = "setlocal cursorline";
          }
          {
            event = "WinLeave";
            pattern = "*";
            command = "setlocal nocursorline";
          }
          {
            event = "TextYankPost";
            pattern = "*";
            callback.__raw = "function() vim.highlight.on_yank() end";
          }
        ];

        plugins.web-devicons = {
          enable = true;
        };

        plugins.emmet = {
          enable = true;
          # blink-cmp owns <C-y> (accept) and <C-e> (hide menu)
          settings.leader_key = "<M-e>";
        };

        plugins.kulala = {
          enable = true;
          settings = {
            default_view = "body";
            default_env = "dev";
          };
        };

        plugins.render-markdown.enable = true;

        plugins.luasnip = {
          enable = true;
          fromVscode = [
            { paths = "${pkgs.vimPlugins.friendly-snippets}"; }
          ];
        };

        plugins.vim-dadbod.enable = true;
        plugins.vim-dadbod-ui.enable = true;

        plugins.which-key = {
          enable = true;
          settings.delay = 300;
        };

        plugins.nui.enable = true;

        plugins.noice = {
          enable = true;
          settings.presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            lsp_doc_border = true;
          };
        };

        plugins.neo-tree = {
          enable = true;
          settings = {
            close_if_last_window = false;
            enable_git_status = true;
            enable_diagnostics = true;
            window = {
              width = 30;
              position = "left";
            };
            filesystem = {
              follow_current_file.enabled = true;
              filtered_items = {
                visible = true;
                hide_dotfiles = false;
                hide_gitignored = false;
              };
            };
          };
        };

        plugins.bufferline = {
          enable = true;
          settings.options = {
            mode = "buffers";
            separator_style = "thin";
            diagnostics = "nvim_lsp";
            always_show_bufferline = true;
            show_buffer_close_icons = false;
            show_close_icon = false;
            color_icons = true;
            offsets = [
              {
                filetype = "neo-tree";
                text = "EXPLORER";
                highlight = "Directory";
                separator = true;
              }
            ];
          };
        };

        colorschemes.catppuccin = {
          enable = false;
          settings = {
            flavour = "mocha";
            transparent_background = true;
            integrations = {
              cmp = true;
              gitsigns = true;
              treesitter = true;
              harpoon = true;
              telescope = true;
              notify = true;
            };
            custom_highlights = ''
              function(colors)
                return {
                  NormalFloat = { bg = "NONE" },
                  FloatBorder = { bg = "NONE" },
                }
              end
            '';
          };
        };

        colorschemes.tokyonight = {
          enable = true;
          settings = {
            style = "storm";
            transparent = true;
            terminal_colors = true;
            styles = {
              sidebars = "dark";
              floats = "dark";
            };
          };
        };

        plugins.dashboard = {
          enable = true;
          settings = {
            theme = "doom";
            config = {
              header = [
                "        "
                "        "
                "        "
                "        "
                "⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣀⣀⣀⢀⣀⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀"
                "⠀⠀⠀⠀⠀⣀⣀⠀⠠⣄⣉⡶⢿⣷⣿⣷⣶⣶⣮⣄⡠⡀⡀⣠⣄⡀⠀⠀⠀⠀"
                "⠀⠀⠀⣄⡾⣫⢒⢾⣾⣿⢟⢥⣶⣶⣶⣮⣖⠾⡙⢿⣿⣦⡊⡲⣶⣆⠀⠀⠀⠀"
                "⠀⠀⠀⢬⣾⢣⣳⣿⡿⢑⣵⣿⣿⣷⠹⣿⣿⣿⣮⡳⡝⣿⣿⡔⠙⣿⣇⠀⠀⠀"
                "⠀⠀⢠⣿⡏⢲⣿⡿⣱⣿⣿⡿⡻⣱⣿⣝⢞⢿⢿⣿⣮⠎⣿⣿⡔⠸⣿⠀⠀⠀"
                "⠀⠀⡜⣾⠁⣿⣿⢳⡿⡛⠁⠌⢾⣿⣿⣿⣧⠀⠑⢝⢿⣏⠘⣿⣷⠀⣿⡆⠀⠀"
                "⠀⢀⢻⡟⣷⣿⣿⣈⣼⣾⣿⣮⣹⣿⣿⣿⣿⣾⣿⣮⣳⢝⣴⢻⣿⢸⢹⣧⡆⠀"
                "⣀⣘⣿⣧⢿⣿⣿⢿⣿⠋⠉⠉⣿⣿⣿⣿⣿⡙⠉⠙⣿⡇⢸⢸⣿⢨⠬⠭⠤⠤"
                "⢢⣝⢿⣯⡝⢿⡟⣼⣿⣿⣿⣿⣿⣿⡉⢙⣿⣿⣿⣿⣿⡏⢄⣿⡟⢰⣿⡿⡧⠇"
                "⡄⣎⣵⡙⡧⢏⢷⢑⢻⣿⣿⣿⣿⣿⣿⡿⢿⣿⣿⣿⣿⠁⣼⠏⠠⠛⣱⣴⡆⡏"
                "⣧⣿⣿⣿⣷⡉⠈⠣⢻⣿⣿⣿⣯⣟⣻⣇⣿⣿⣿⣿⡿⢑⠁⠁⢲⣿⣿⣿⣇⣷"
                "⢸⣿⣿⣿⣿⣇⠀⠀⠈⠻⢿⣿⣿⣿⣿⣿⣿⣿⣿⠟⠑⠁⠀⠀⢸⣿⣿⣿⣿⣿"
                "⢸⣿⣿⣿⣿⣿⠀⠀⠀⣀⠀⠈⠹⠛⣻⣛⠻⠉⠀⡀⢸⣀⠀⠀⣸⣿⣿⠿⢨⣿"
                "⢸⡏⣿⣿⣿⣿⣧⢰⣿⢸⡄⠁⠢⠀⣤⣤⣤⡲⠟⡁⣾⣿⣿⢸⡟⣛⣵⡇⡼⡿"
                "⢀⣟⠹⠻⣟⣛⢿⣾⢧⢀⣿⡸⢣⢾⣟⢿⢣⣼⣶⣠⣟⣛⣻⣴⡆⣿⣿⢁⠇⣦"
                "        "
                "        "
                "        "
              ];
              center = [
                {
                  icon = " ";
                  desc = "Find File              ";
                  action = "Telescope find_files";
                  key = "f";
                }
                {
                  icon = " ";
                  desc = "Quit Neovim          ";
                  action = "qa";
                  key = "q";
                }
              ];
            };
          };
        };

        plugins.indent-blankline = {
          enable = true;
          settings.exclude.filetypes = [ "dashboard" ];
        };

        plugins.neoscroll = {
          enable = true;
          settings = {
            easing = "linear";
            cursor_scrolls_alone = true;
            mappings = [
              "<C-u>"
              "<C-d>"
            ];
            duration_multiplier = 0.5;
          };
        };

        plugins.notify = {
          enable = true;
          settings = {
            background_colour = "#000000";
            render = "compact";
            stages = "fade";
            timeout = 2000;
            max_width = 60;
          };
        };

        plugins.telescope = {
          enable = true;
          keymaps = {
            "<leader>ff" = {
              action = "find_files";
              options.desc = "Telescope Find Files";
            };
            "<leader>fg" = {
              action = "live_grep";
              options.desc = "Telescope Live Grep";
            };
            "<leader>fb" = {
              action = "buffers";
              options.desc = "Telescope Buffers";
            };
            "<leader>fh" = {
              action = "help_tags";
              options.desc = "Telescope Help";
            };
          };
        };

        plugins.oil = {
          enable = true;
          settings = {
            default_file_explorer = true;
            columns = [ "icon" ];
            delete_to_trash = false;
            skip_confirm_for_simple_edits = false;
            view_options = {
              show_hidden = false;
            };
            float = {
              padding = 2;
              max_width = 0;
              max_height = 0;
              border = "rounded";
            };
            keymaps = {
              "g?" = "actions.show_help";
              "<CR>" = "actions.select";
              "-" = "actions.parent";
              "_" = "actions.open_cwd";
            };
          };
        };

        plugins.treesitter = {
          enable = true;
          nixGrammars = true;
          grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
            html
            css
            javascript
            typescript
            tsx
            json
            yaml
            markdown
            nix
            lua
          ];
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
        };

        plugins.ts-autotag = {
          enable = true;
        };

        plugins.nvim-autopairs.enable = true;

        plugins.gitsigns = {
          enable = true;
          settings.signs = {
            add = {
              text = "┃";
            };
            change = {
              text = "┃";
            };
            delete = {
              text = "_";
            };
            topdelete = {
              text = "‾";
            };
            changedelete = {
              text = "~";
            };
          };
        };

        plugins.lsp = {
          enable = true;
          servers = {
            intelephense = {
              enable = true;
              package = pkgs.intelephense;
              settings = {
                files.maxSize = 5000000;
                environment.phpVersion = "8.4";
              };
            };
            html.enable = true;
            cssls.enable = true;
            tailwindcss = {
              enable = true;
              settings = {
                tailwindCSS.experimental.classRegex = [
                  "class\\s*=\\s*['\"]([^'\"]*)['\"]"
                  "className\\s*=\\s*['\"]([^'\"]*)['\"]"
                  "className\\s*=\\s*\\{`([^`]*)`\\}"
                ];
              };
            };
            jsonls = {
              enable = true;
            };
            nixd = {
              enable = true;
              settings.formatting.command = [ "nixpkgs-fmt" ];
            };
            nil_ls.enable = true;
            ts_ls.enable = true;
            bashls.enable = true;
            pyright.enable = true;

            qmlls = {
              enable = true;
              filetypes = [
                "qmljs"
                "qml"
              ];
            };
            tinymist = {
              enable = true;
              filetypes = [ "typ" ];
            };
            texlab.enable = true;
            lua_ls = {
              enable = true;
              settings.Lua = {
                workspace = {
                  checkThirdParty = false;
                  library = [{ __raw = "vim.env.VIMRUNTIME"; }];
                };
                hint = {
                  enable = true;
                  setType = false;
                  paramType = true;
                  paramName = "Disable";
                  semicolon = "Disable";
                  arrayIndex = "Disable";
                };
                doc.privateName = [ "^_" ];
                type.castNumberToInteger = true;
                diagnostics = {
                  disable = [
                    "incomplete-signature-doc"
                    "trailing-space"
                  ];
                  groupSeverity = {
                    strong = "Warning";
                    strict = "Warning";
                  };
                  groupFileStatus = {
                    ambiguity = "Opened";
                    await = "Opened";
                    codestyle = "None";
                    duplicate = "Opened";
                    global = "Opened";
                    luadoc = "Opened";
                    redefined = "Opened";
                    strict = "Opened";
                    strong = "Opened";
                    "type-check" = "Opened";
                    unbalanced = "Opened";
                    unused = "Opened";
                  };
                  unusedLocalExclude = [ "_*" ];
                };
              };
            };
            rust_analyzer = {
              enable = true;
              installCargo = false;
              installRustc = false;
            };
          };
        };
        # craftzdog plugins (solarized-osaka installed via extraPlugins; catppuccin stays default)
        plugins.snacks = {
          enable = true;
          settings = {
            indent.enabled = true;
            scroll.enabled = false;
            picker = {
              enabled = true;
              sources.files.hidden = true;
              sources.grep.hidden = true;
            };
            notifier.enabled = true;
            statuscolumn.enabled = true;
            words.enabled = true;
            lazygit = {
              enabled = true;
              configure = true;
              config.os = {
                edit.__raw = "require('craftzdog.utils.lazygit').edit_command()";
                editAtLine.__raw = "require('craftzdog.utils.lazygit').edit_command({ at_line = true })";
              };
              theme.activeBorderColor = {
                fg = "WarningMsg";
                bold = true;
              };
            };
          };
        };

        plugins.blink-cmp = {
          enable = true;
          settings = {
            snippets.preset = "luasnip";
            completion = {
              accept.auto_brackets.enabled = true;
              menu = {
                border = "none";
                draw.treesitter = [ "lsp" ];
              };
              documentation = {
                auto_show = true;
                auto_show_delay_ms = 200;
              };
              ghost_text.enabled = true;
            };
            cmdline = {
              enabled = true;
              keymap = {
                preset = "cmdline";
                "<Right>" = false;
                "<Left>" = false;
              };
              completion = {
                list.selection.preselect = false;
                menu.auto_show.__raw = "function(ctx) return vim.fn.getcmdtype() == ':' end";
                ghost_text.enabled = true;
              };
            };
            keymap = {
              preset = "enter";
              "c-y" = [ "select_and_accept" ];
            };
            appearance.kind_icons.__raw = "Craftzdog.icons.kinds";
          };
        };

        plugins.conform-nvim = {
          enable = true;
          settings = {
            default_format_opts = {
              timeout_ms = 3000;
              async = false;
              quiet = false;
              lsp_format = "fallback";
            };
            formatters_by_ft.__raw = ''
              (function()
                local f = { "oxfmt", "prettierd", "prettier", stop_after_first = true }
                return {
                  javascript = f,
                  typescript = f,
                  javascriptreact = f,
                  typescriptreact = f,
                  json = f,
                  css = f,
                  html = f,
                  markdown = f,
                  yaml = f,
                  less = f,
                  scss = f,
                  ["markdown.mdx"] = f,
                  lua = { "stylua" },
                  sh = { "shfmt" },
                  fish = { "fish_indent" },
                }
              end)()
            '';
            formatters.oxfmt.require_cwd = true;
            format_on_save.__raw = ''
              function(bufnr)
                if vim.b[bufnr].disable_autoformat then
                  return
                end
                return { timeout_ms = 500, lsp_fallback = true }
              end
            '';
          };
        };

        plugins.todo-comments.enable = true;
        plugins.gitlinker.enable = true;
        plugins.trouble.enable = true;

        plugins.flash.enable = true;
        plugins.mini-surround.enable = true;
        plugins.mini-ai.enable = true;
        plugins.mini-comment.enable = true;
        plugins.illuminate.enable = true;
        plugins.lsp-signature.enable = true;
        plugins.yanky.enable = true;
        plugins.diffview.enable = true;
        plugins.undotree.enable = true;
        plugins.spectre.enable = true;

        plugins.treesitter-context = {
          enable = true;
          settings.max_lines = 3;
        };

        plugins.inc-rename = {
          enable = true;
          settings.input_buffer_type = "snacks";
        };

        plugins.highlight-colors = {
          enable = true;
          settings = {
            render = "background";
            enable_hex = true;
            enable_short_hex = true;
            enable_rgb = true;
            enable_hsl = true;
            enable_hsl_without_function = true;
            enable_ansi = true;
            enable_var_usage = true;
            enable_tailwind = true;
          };
        };

        plugins.lint = {
          enable = true;
          autoInstall.enable = true;
          lintersByFt = {
            html = [ "htmlhint" ];
            css = [ "stylelint" ];
            scss = [ "stylelint" ];
            less = [ "stylelint" ];
            javascript = [ "eslint" ];
            javascriptreact = [ "eslint" ];
            typescript = [ "eslint" ];
            typescriptreact = [ "eslint" ];
          };
        };

        plugins.copilot-lua = {
          enable = true;
          settings = {
            suggestion = {
              auto_trigger = true;
              keymap = {
                accept = "<C-l>";
                accept_word = "<M-l>";
                accept_line = "<M-S-l>";
                next = "<M-]>";
                prev = "<M-[>";
                dismiss = "<C-]>";
              };
            };
            filetypes = {
              markdown = true;
              help = true;
            };
          };
        };

        filetype.extension.mjml = "html";

        extraConfigLua = ''
          require("livepreview.config").set({ picker = "snacks.picker" })

          local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
          for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
          end

          -- craftzdog UI
          require("mini.icons").setup()
          require("mini.icons").mock_nvim_web_devicons()

          require("mini.diff").setup({
            view = { overlay_style = "hunk" },
            mappings = { goto_next = "]c", goto_prev = "[c" },
          })

          require("incline").setup({
            window = {
              margin = { vertical = 0, horizontal = 1 },
              zindex = 10,
            },
            hide = { cursorline = "smart" },
            render = function(props)
              local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
              if vim.bo[props.buf].modified then
                filename = "[+] " .. filename
              end
              local icon, hl = MiniIcons.get("file", filename)
              return { { icon, group = hl }, { " " }, { filename } }
            end,
          })

          require("codediff").setup({
            explorer = {
              width = 50,
              auto_open_on_cursor = true,
              view_mode = "tree",
              line_stats = { enabled = true },
            },
            diff = {
              compact = true,
              compact_context_lines = 8,
              compact_sync_folds = true,
            },
            keymaps = { view = {} },
          })

          require("lualine").setup({
            options = {
              theme = "auto",
              globalstatus = true,
              disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
              refresh = {
                events = {
                  "WinEnter", "BufEnter", "BufWritePost", "SessionLoadPost", "FileChangedShellPost",
                  "VimResized", "Filetype", "CursorMoved", "CursorMovedI", "ModeChanged",
                  "RecordingEnter", "RecordingLeave",
                },
              },
            },
            sections = {
              lualine_a = { "mode" },
              lualine_b = { "branch" },
              lualine_c = {
                Craftzdog.lualine.root_dir(),
                { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
                Craftzdog.lualine.pretty_path({
                  length = 0,
                  relative = "cwd",
                  modified_hl = "MatchParen",
                  directory_hl = "",
                  filename_hl = "Bold",
                  modified_sign = "",
                  readonly_icon = " 󰌾 ",
                }),
              },
              lualine_x = {
                Craftzdog.lualine.macro_recording(),
                {
                  "diagnostics",
                  symbols = {
                    error = Craftzdog.icons.diagnostics.Error,
                    warn = Craftzdog.icons.diagnostics.Warn,
                    info = Craftzdog.icons.diagnostics.Info,
                    hint = Craftzdog.icons.diagnostics.Hint,
                  },
                },
                {
                  "diff",
                  symbols = {
                    added = Craftzdog.icons.git.added,
                    modified = Craftzdog.icons.git.modified,
                    removed = Craftzdog.icons.git.removed,
                  },
                  source = function()
                    local gitsigns = vim.b.gitsigns_status_dict
                    if gitsigns then
                      return {
                        added = gitsigns.added,
                        modified = gitsigns.changed,
                        removed = gitsigns.removed,
                      }
                    end
                  end,
                },
              },
              lualine_y = {
                { "progress", separator = " ", padding = { left = 1, right = 1 } },
              },
              lualine_z = {
                { "location", padding = { left = 1, right = 1 } },
              },
            },
          })

          vim.diagnostic.config({
            underline = true,
            update_in_insert = false,
            virtual_text = {
              spacing = 4,
              source = "if_many",
              prefix = "●",
              format = function(diagnostic)
                return string.format("%s (%s: %s)", diagnostic.message, diagnostic.source, diagnostic.code)
              end,
            },
            severity_sort = true,
            signs = {
              text = {
                [vim.diagnostic.severity.ERROR] = Craftzdog.icons.diagnostics.Error,
                [vim.diagnostic.severity.WARN] = Craftzdog.icons.diagnostics.Warn,
                [vim.diagnostic.severity.HINT] = Craftzdog.icons.diagnostics.Hint,
                [vim.diagnostic.severity.INFO] = Craftzdog.icons.diagnostics.Info,
              },
            },
          })
        '';

        plugins.harpoon = {
          enable = true;
          enableTelescope = true;
        };

        plugins.typst-preview = {
          enable = true;
          settings = {
            open_cmd = "xdg-open %s";
          };
        };

        plugins.orgmode = {
          enable = true;
          settings = {
            org_agenda_files = "~/orgfiles/**/*";
            org_default_notes_file = "~/orgfiles/refile.org";
          };
        };

        plugins.neorg = {
          enable = true;
          settings.load = {
            "core.defaults" = {
              __empty = null;
            };
            "core.concealer" = {
              config = {
                icon_preset = "diamond";
              };
            };
            "core.dirman" = {
              config = {
                workspaces = {
                  notes = "~/notes";
                };
                default_workspace = "notes";
              };
            };
            "core.summary" = {
              config = {
                strategy = "by_path";
                link_format = "friendly";
              };
            };
            "core.esupports.indent" = {
              __empty = null;
            };
            "core.integrations.treesitter" = {
              __empty = null;
            };
            "core.export" = {
              __empty = null;
            };
            "core.tangle" = {
              __empty = null;
            };
          };
        };

        keymaps = [
          {
            mode = "n";
            key = "<leader>a";
            action.__raw = "function() require('harpoon'):list():add() end";
            options.desc = "Harpoon Add File";
          }
          {
            mode = "n";
            key = "<leader>h";
            action.__raw = "function() local harpoon = require('harpoon'); harpoon.ui:toggle_quick_menu(harpoon:list()) end";
            options.desc = "Harpoon Menu";
          }
          {
            mode = "n";
            key = "<M-1>";
            action.__raw = "function() require('harpoon'):list():select(1) end";
            options.desc = "Harpoon File 1";
          }
          {
            mode = "n";
            key = "<M-2>";
            action.__raw = "function() require('harpoon'):list():select(2) end";
            options.desc = "Harpoon File 2";
          }
          {
            mode = "n";
            key = "<M-3>";
            action.__raw = "function() require('harpoon'):list():select(3) end";
            options.desc = "Harpoon File 3";
          }
          {
            mode = "n";
            key = "<M-4>";
            action.__raw = "function() require('harpoon'):list():select(4) end";
            options.desc = "Harpoon File 4";
          }
          {
            mode = "n";
            key = "<S-Tab>";
            action.__raw = "function() require('harpoon'):list():next() end";
            options.desc = "Harpoon Next";
          }
          {
            mode = "n";
            key = "<Tab>";
            action.__raw = "function() require('harpoon'):list():prev() end";
            options.desc = "Harpoon Prev";
          }
          # regular keymaps
          {
            mode = "n";
            key = "<leader>w";
            action = "<cmd>w<CR>";
            options.desc = "Save";
          }
          {
            mode = "n";
            key = "<leader>q";
            action = "<cmd>cclose<CR>";
            options = {
              silent = true;
              desc = "Close Quickfix";
            };
          }
          {
            mode = "n";
            key = "<leader>o";
            action = "<cmd>update<CR><cmd>source %<CR>";
            options.desc = "Update and Source";
          }
          {
            mode = "v";
            key = "<C-j>";
            action = ":m '>+1<CR>gv=gv";
            options = {
              silent = true;
              desc = "Move line down";
            };
          }
          {
            mode = "v";
            key = "<C-k>";
            action = ":m '<-2<CR>gv=gv";
            options = {
              silent = true;
              desc = "Move line up";
            };
          }
          {
            mode = "n";
            key = "<leader>lf";
            action = "<cmd>lua vim.lsp.buf.format()<CR>";
            options.desc = "LSP Format";
          }
          {
            mode = "n";
            key = "-";
            action = "<cmd>Oil<CR>";
            options.desc = "Open Parent Directory";
          }
          {
            mode = "n";
            key = "<leader>l";
            action = "<cmd>lua require('notify').dismiss({ silent = true, pending = true })<CR>";
            options.desc = "Dismiss Notifications";
          }
          {
            mode = "n";
            key = "[d";
            action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
          }
          {
            mode = "n";
            key = "]d";
            action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
          }
          {
            mode = "n";
            key = "<leader>d";
            action = "<cmd>lua vim.diagnostic.open_float()<CR>";
          }
          {
            mode = "n";
            key = "<leader>ll";
            action = "\\lv";
            options = {
              remap = true;
              desc = "VimTeX Preview";
            };
          }
          # craftzdog keymaps (colliding ones skipped: <tab>/<s-tab> harpoon, "-" oil, <leader>o, <leader>d, <leader>f)
          {
            mode = "n";
            key = "x";
            action = "\"_x";
            options.desc = "Delete without yanking";
          }
          {
            mode = "n";
            key = "<leader>p";
            action = "\"0p";
            options.desc = "Paste last yank";
          }
          {
            mode = "n";
            key = "<leader>P";
            action = "\"0P";
            options.desc = "Paste last yank before";
          }
          {
            mode = "v";
            key = "<leader>p";
            action = "\"0p";
            options.desc = "Paste last yank";
          }
          {
            mode = "n";
            key = "<leader>c";
            action = "\"_c";
            options.desc = "Change without yanking";
          }
          {
            mode = "n";
            key = "<leader>C";
            action = "\"_C";
            options.desc = "Change to EOL without yanking";
          }
          {
            mode = "v";
            key = "<leader>c";
            action = "\"_c";
            options.desc = "Change without yanking";
          }
          {
            mode = "v";
            key = "<leader>C";
            action = "\"_C";
            options.desc = "Change to EOL without yanking";
          }
          {
            mode = "n";
            key = "+";
            action = "<C-a>";
            options.desc = "Increment";
          }
          {
            mode = "n";
            key = "dw";
            action = "vb\"_d";
            options.desc = "Delete word backwards";
          }
          {
            mode = "n";
            key = "<C-a>";
            action = "gg<S-v>G";
            options.desc = "Select all";
          }
          {
            mode = "n";
            key = "<C-m>";
            action = "<C-i>";
            options.desc = "Jump forward";
          }
          {
            mode = "n";
            key = "te";
            action = ":tabedit<CR>";
            options.desc = "New tab";
          }
          {
            mode = "n";
            key = "ss";
            action = ":split<Return>";
            options.desc = "Split below";
          }
          {
            mode = "n";
            key = "sv";
            action = ":vsplit<Return>";
            options.desc = "Split right";
          }
          {
            mode = "n";
            key = "sh";
            action = "<C-w>h";
            options.desc = "Window left";
          }
          {
            mode = "n";
            key = "sk";
            action = "<C-w>k";
            options.desc = "Window up";
          }
          {
            mode = "n";
            key = "sj";
            action = "<C-w>j";
            options.desc = "Window down";
          }
          {
            mode = "n";
            key = "sl";
            action = "<C-w>l";
            options.desc = "Window right";
          }
          {
            mode = "n";
            key = "<leader>yf";
            action.__raw = "function() require('craftzdog.utils.editor').yank_relative_path_with_line() end";
            options.desc = "Yank relative path with line";
          }
          {
            mode = "n";
            key = "<leader>yp";
            action.__raw = "function() require('craftzdog.utils.editor').yank_absolute_path_with_line() end";
            options.desc = "Yank absolute path with line";
          }
          {
            mode = "v";
            key = "<leader>cc";
            action = ":<C-u>lua require('craftzdog.utils.editor').copy_as_codeblock()<CR>";
            options.desc = "Copy as codeblock";
          }
          {
            mode = "n";
            key = "<leader>j";
            action.__raw = "function() require('craftzdog.utils.editor').open_package_json() end";
            options.desc = "Open package.json";
          }
          {
            mode = "n";
            key = "<leader>bd";
            action.__raw = "function() require('craftzdog.utils.editor').delete_hidden_buffers() end";
            options.desc = "Delete hidden buffers";
          }
          {
            mode = "n";
            key = "sf";
            action.__raw = "function() require('oil').open_float(nil, { preview = {} }) end";
            options.desc = "File explorer (float preview)";
          }
          {
            mode = "n";
            key = "gI";
            action.__raw = ''
              function()
                local clients = vim.lsp.get_clients({ bufnr = 0, name = "vtsls" })
                if #clients > 0 then
                  local params = vim.lsp.util.make_position_params(0, "utf-16")
                  clients[1]:request("workspace/executeCommand", {
                    command = "typescript.goToSourceDefinition",
                    arguments = { params.textDocument.uri, params.position },
                  }, function(err, result)
                    if err then
                      vim.notify("goToSourceDefinition: " .. err.message, vim.log.levels.ERROR)
                      return
                    end
                    if result and #result > 0 then
                      vim.lsp.util.show_document(result[1], "utf-16", { focus = true })
                    else
                      vim.notify("No source definition found", vim.log.levels.INFO)
                    end
                  end, 0)
                else
                  vim.lsp.buf.implementation()
                end
              end
            '';
            options.desc = "Goto Source Definition / Implementation";
          }
          {
            mode = "n";
            key = "gd";
            action.__raw = "function() require('snacks').picker.lsp_definitions({ jump = { reuse_win = false } }) end";
            options.desc = "LSP Goto Definition";
          }
          {
            mode = "n";
            key = "gD";
            action.__raw = "function() require('snacks').picker.lsp_declarations() end";
            options.desc = "LSP Goto Declaration";
          }
          {
            mode = "n";
            key = "gy";
            action.__raw = "function() require('snacks').picker.lsp_type_definitions() end";
            options.desc = "LSP Goto Type Definition";
          }
          {
            mode = "n";
            key = "gr";
            action.__raw = "function() require('snacks').picker.lsp_references() end";
            options.desc = "LSP References";
          }
          {
            mode = "n";
            key = "K";
            action.__raw = "vim.lsp.buf.hover";
            options.desc = "Hover";
          }
          {
            mode = "n";
            key = "gK";
            action.__raw = "vim.lsp.buf.signature_help";
            options.desc = "Signature Help";
          }
          {
            mode = "i";
            key = "<c-k>";
            action.__raw = "vim.lsp.buf.signature_help";
            options.desc = "Signature Help";
          }
          {
            mode = "n";
            key = "<c-j>";
            action.__raw = "function() vim.diagnostic.jump({ count = 1, float = true }) end";
            options.desc = "Next diagnostic";
          }
          {
            mode = [
              "n"
              "x"
            ];
            key = "<leader>ca";
            action.__raw = "vim.lsp.buf.code_action";
            options.desc = "Code Action";
          }
          {
            mode = "n";
            key = "<leader>cr";
            action = "<cmd>IncRename <cword><CR>";
            options.desc = "Rename (live preview)";
          }
          {
            mode = [
              "n"
              "x"
            ];
            key = "<leader>lF";
            action.__raw = "function() require('conform').format() end";
            options.desc = "Format (conform)";
          }
          {
            mode = "n";
            key = "<leader>cl";
            action.__raw = "function() require('snacks').picker.lsp_config() end";
            options.desc = "Lsp Info";
          }
          {
            mode = "n";
            key = "<leader>cR";
            action.__raw = "function() require('snacks').rename.rename_file() end";
            options.desc = "Rename File";
          }
          {
            mode = "n";
            key = ";f";
            action.__raw = "function() require('snacks').picker.files() end";
            options.desc = "Find files (snacks)";
          }
          {
            mode = "n";
            key = ";r";
            action.__raw = "function() require('snacks').picker.grep() end";
            options.desc = "Live grep (snacks)";
          }
          {
            mode = "n";
            key = ";;";
            action.__raw = "function() require('snacks').picker.resume() end";
            options.desc = "Resume picker";
          }
          {
            mode = "n";
            key = "\\\\";
            action.__raw = ''
              function()
                require('snacks').picker.buffers({
                  confirm = function(picker, item)
                    picker:close()
                    if not item then
                      return
                    end
                    vim.schedule(function()
                      for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
                        for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
                          if vim.api.nvim_win_get_buf(win) == item.buf then
                            vim.api.nvim_set_current_tabpage(tab)
                            vim.api.nvim_set_current_win(win)
                            return
                          end
                        end
                      end
                      vim.api.nvim_set_current_buf(item.buf)
                    end)
                  end,
                })
              end
            '';
            options.desc = "List buffers";
          }
          {
            mode = "n";
            key = ";e";
            action.__raw = "function() require('snacks').picker.diagnostics() end";
            options.desc = "Diagnostics";
          }
          {
            mode = "n";
            key = ";c";
            action.__raw = "function() require('snacks').picker.lsp_incoming_calls() end";
            options.desc = "LSP incoming calls";
          }
          {
            mode = "n";
            key = ";n";
            action.__raw = "function() require('snacks').picker.notifications() end";
            options.desc = "Notifications";
          }
          {
            mode = "n";
            key = ";g";
            action.__raw = "function() require('craftzdog.utils.lazygit').open() end";
            options.desc = "Lazygit";
          }
          {
            mode = "n";
            key = ";h";
            action.__raw = "function() require('snacks').picker.git_diff() end";
            options.desc = "Git Diff (Hunks)";
          }
          {
            mode = [
              "n"
              "t"
            ];
            key = "]]";
            action.__raw = "function() require('snacks').words.jump(vim.v.count1) end";
            options.desc = "Next Reference";
          }
          {
            mode = [
              "n"
              "t"
            ];
            key = "[[";
            action.__raw = "function() require('snacks').words.jump(-vim.v.count1) end";
            options.desc = "Prev Reference";
          }
          {
            mode = "n";
            key = "<leader>gb";
            action.__raw = "function() require('gitsigns').blame_line() end";
            options.desc = "Blame current line";
          }
          {
            mode = "n";
            key = "<leader>gB";
            action.__raw = "function() require('gitsigns').blame() end";
            options.desc = "Blame buffer";
          }
          {
            mode = "n";
            key = "<leader>go";
            action.__raw = ''
              function()
                local async = require("gitsigns.async")
                local cache = require("gitsigns.cache").cache
                async.run(function()
                  local bufnr = vim.api.nvim_get_current_buf()
                  local lnum = vim.api.nvim_win_get_cursor(0)[1]
                  local bcache = cache[bufnr]
                  if not bcache then
                    return
                  end
                  bcache:get_blame(lnum)
                  local blame = bcache.blame
                  if not blame or not blame.entries or not blame.entries[lnum] then
                    return
                  end
                  local info = blame.entries[lnum]
                  local sha = info.commit.sha
                  if tonumber("0x" .. sha:sub(1, 8)) == 0 then
                    vim.notify("Line not committed yet", vim.log.levels.WARN)
                    return
                  end
                  vim.cmd.tabnew()
                  require("gitsigns.actions.diffthis").show(bufnr, sha, info.filename)
                  async.schedule()
                  pcall(vim.api.nvim_win_set_cursor, 0, { info.orig_lnum or lnum, 0 })
                end)
              end
            '';
            options.desc = "Open file from blamed commit";
          }
          {
            mode = "n";
            key = "<leader>gs";
            action.__raw = ''
              function()
                local gs = require("gitsigns")
                if #(gs.get_hunks() or {}) > 0 then
                  gs.stage_buffer()
                else
                  gs.reset_buffer_index()
                end
              end
            '';
            options.desc = "Toggle stage buffer";
          }
          {
            mode = "n";
            key = "<leader>gh";
            action.__raw = "function() require('gitsigns').stage_hunk() end";
            options.desc = "Toggle stage hunk";
          }
          {
            mode = "n";
            key = "<leader>gd";
            action.__raw = "function() require('mini.diff').toggle_overlay() end";
            options.desc = "Toggle MiniDiff overlay";
          }
          {
            mode = "n";
            key = "<leader>dv";
            action = "<cmd>CodeDiff<cr>";
            options.desc = "Toggle CodeDiff";
          }
          {
            mode = "n";
            key = "<leader>dh";
            action = "<cmd>CodeDiff history %<cr>";
            options.desc = "File history (current file)";
          }
          {
            mode = "n";
            key = "<leader>dH";
            action = "<cmd>CodeDiff history<cr>";
            options.desc = "File history (repo)";
          }
          {
            mode = "n";
            key = "<leader>e";
            action = "<cmd>Neotree toggle<CR>";
            options.desc = "Explorer";
          }
          {
            mode = "n";
            key = "<S-l>";
            action = "<cmd>BufferLineCycleNext<CR>";
            options.desc = "Next buffer";
          }
          {
            mode = "n";
            key = "<S-h>";
            action = "<cmd>BufferLineCyclePrev<CR>";
            options.desc = "Prev buffer";
          }
          {
            mode = "n";
            key = "<leader>tt";
            action.__raw = "function() Snacks.terminal() end";
            options.desc = "Terminal";
          }
          {
            mode = "n";
            key = "<leader>z";
            action.__raw = "function() Snacks.zen() end";
            options.desc = "Zen mode";
          }
          {
            mode = "n";
            key = "<leader>hs";
            action.__raw = "function() require('kulala').run() end";
            options.desc = "HTTP Send Request";
          }
          {
            mode = "n";
            key = "<leader>db";
            action = "<cmd>DBUI<CR>";
            options.desc = "Database UI";
          }
          {
            mode = "n";
            key = "<leader>lp";
            action = "<cmd>LivePreview pick<CR>";
            options.desc = "Live Preview (pick file)";
          }
          {
            mode = "n";
            key = "<leader>u";
            action = "<cmd>UndotreeToggle<CR>";
            options.desc = "Undo tree";
          }
          {
            mode = "n";
            key = "<leader>sr";
            action.__raw = "function() require('spectre').open() end";
            options.desc = "Search & Replace (project)";
          }
          {
            mode = "n";
            key = "<leader>yh";
            action = "<cmd>YankyRingHistory<CR>";
            options.desc = "Yank history";
          }
          {
            mode = "n";
            key = "<leader>gv";
            action = "<cmd>DiffviewOpen<CR>";
            options.desc = "Diff view";
          }
          {
            mode = "n";
            key = "<leader>gq";
            action = "<cmd>DiffviewClose<CR>";
            options.desc = "Close diff view";
          }
          {
            mode = [
              "n"
              "x"
            ];
            key = "p";
            action = "<Plug>(YankyPutAfter)";
            options.desc = "Put after (yank ring)";
          }
          {
            mode = [
              "n"
              "x"
            ];
            key = "P";
            action = "<Plug>(YankyPutBefore)";
            options.desc = "Put before (yank ring)";
          }
          {
            mode = "n";
            key = "<C-n>";
            action = "<Plug>(YankyNextEntry)";
            options.desc = "Next yank";
          }
          {
            mode = "n";
            key = "<C-p>";
            action = "<Plug>(YankyPreviousEntry)";
            options.desc = "Previous yank";
          }
        ];
      };
    };
}
