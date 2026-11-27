{ ... }:

{
  # Caches available on both hosts.
  flake.modules.nixos.binary-caches = {
    nix.settings = {
      extra-substituters = [
        "https://cache.manic.systems" # general extra cache
        "https://umbriel.cachix.org" # Umbriel compositor builds
        "https://noctalia.cachix.org" # Noctalia shell/panel builds
      ];

      extra-trusted-public-keys = [
        "cache.manic.systems-1:s6OZanN8Us8vRi0jVivP3qlMn0cYHBjBALKrNe5nH8s="
        "umbriel.cachix.org-1:JfNq/2yg2S6D6z4Z2dVSZrZlDPQTKtexB6GAVLD98nw="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      ];
    };
  };

  # Caches only needed by the desktop's CachyOS kernel and ollama-cuda.
  flake.modules.nixos.binary-caches-desktop = {
    nix.settings = {
      extra-substituters = [
        "https://cache.lantian.pub/lantian" # CachyOS kernel packages
        "https://cache.numtide.com" # llm-agents / opencode tooling
        "https://cache.nixos-cuda.org" # CUDA builds for ollama-cuda
      ];

      extra-trusted-public-keys = [
        "lantian:WVGO7vsRMSEN+h7Lp7kv6SAmrkEXgUGbbXm7jMDjBuQ="
        "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
  };
}
