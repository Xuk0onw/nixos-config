{ inputs, ... }:

{
  flake.modules.homeManager.opencode = { pkgs, ... }:

  let
    engine = pkgs.stdenv.mkDerivation {
      pname = "impeccable-engine";
      version = "0.1.27";
      src = pkgs.fetchurl {
        url = "https://github.com/pbakaus/impeccable/releases/download/engine-v0.1.27/impeccable-linux-x64";
        sha256 = "41d66e945bcdfc560005b61ad0b6b2312b124890039262f2e63322ef2709ccfd";
      };
      dontUnpack = true;
      installPhase = "install -Dm755 $src $out/bin/impeccable";
    };
  in
  {
    xdg.configFile."opencode/opencode.jsonc".source = ./config/opencode/opencode.jsonc;
    xdg.configFile."opencode/skills/impeccable".source =
      "${inputs.impeccable}/.opencode/skills/impeccable";
    xdg.configFile."opencode/commands/impeccable.md".source =
      "${inputs.impeccable}/.opencode/commands/impeccable.md";
    xdg.configFile."opencode/skills/grilling".source =
      "${inputs.mattpocock-skills}/skills/productivity/grilling";
    xdg.configFile."opencode/skills/diagnosing-bugs".source =
      "${inputs.mattpocock-skills}/skills/engineering/diagnosing-bugs";
    xdg.configFile."opencode/skills/codebase-design".source =
      "${inputs.mattpocock-skills}/skills/engineering/codebase-design";
    home.file.".impeccable/bin/impeccable".source = "${engine}/bin/impeccable";

    home.packages = with pkgs; [
      uv
    ];

    nix.settings = {
      extra-substituters = [
        "https://cache.numtide.com"
      ];

      extra-trusted-public-keys = [
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      ];
    };
  };
}
