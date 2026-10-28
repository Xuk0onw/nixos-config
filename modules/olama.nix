
{ pkgs, ... }:

{
  nix.settings = {
    extra-substituters = [
      "https://cache.numtide.com"
      #"https://cache.nixos-cuda.org"
       "https://cache.flox.dev"
    ];

    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
      #"cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      "flox-cache-public-1:7F4OyH7ZCnFhcze3fJdfyXYLQw/aV7GEed86nQ7IsOs="
    ];
  };

  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [ "gemma4:e4b" ];
  };
}
