
{ pkgs, ... }:

{
  nix.settings = {
    extra-substituters = [
      "https://cache.numtide.com"
      "https://cache.nixos-cuda.org"
    ];

    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
    ];
  };

  services.ollama = {
    enable = false;
    package = pkgs.ollama-cuda;
    loadModels = [ "gemma4:e4b" ];
  };
}
