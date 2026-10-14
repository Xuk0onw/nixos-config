{ device, ... }:
{
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.fish = {
    enable = true;

    shellAliases = {
      ll = "eza -l";
      ls = "eza";
      la = "eza -a";
      lla = "eza -la";
      vim = "nvim";
      vi = "nvim";
      nrs = "sudo nixos-rebuild switch --flake .#${if device == "thinkpad" then "thinkpad" else "desktop"}";
    };

    interactiveShellInit = ''
      set -g fish_greeting ""

      if test "$TERM" != "dumb"
          fastfetch
      end

      printf '\e[2 q'
      function force_cursor_block --on-event fish_prompt
          printf '\e[2 q'
      end

      set -g fish_color_normal D8DEE9
      set -g fish_color_command EBCB8B --bold
      set -g fish_color_keyword 81A1C1
      set -g fish_color_quote A3BE8C
      set -g fish_color_redirection 88C0D0
      set -g fish_color_end B48EAD
      set -g fish_color_error BF616A
      set -g fish_color_param D8DEE9
      set -g fish_color_comment 4C566A
      set -g fish_color_autosuggestion 4C566A
    '';

    functions = {
      fish_prompt = ''
        set -l last_status $status

        # Colors
        set -l path_blue (set_color --bold 81A1C1)
        set -l git_red (set_color BF616A)
        set -l green (set_color A3BE8C)
        set -l text (set_color D8DEE9)
        set -l normal (set_color normal)
        echo -n $text"╭─  "
        echo -n $path_blue"["(prompt_pwd)"]"

        if type -q git
            set -l git_branch (git branch --show-current 2>/dev/null)

            if test -n "$git_branch"
                echo -n $text"("$git_red$git_branch$text")"
                set -l dirty (git status --porcelain --ignore-submodules=dirty 2>/dev/null)
                if test -n "$dirty"
                   echo -n $git_red"*"$normal
                end
            end
        end
        echo # New line
        echo -n $text"╰─ "

        if test $last_status -eq 0
            echo -n $green"λ "$normal
        else
            echo -n $git_red"λ "$normal
        end
      '';

      fish_right_prompt = "";
    };
  };
}
