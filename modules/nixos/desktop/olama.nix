{ ... }:

{
  flake.modules.nixos.ollama = { pkgs, ... }: {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-cuda;

      environmentVariables = {
        OLLAMA_NUM_PARALLEL = "1";
        OLLAMA_MAX_LOADED_MODELS = "1";
        OLLAMA_FLASH_ATTENTION = "1";
        OLLAMA_KV_CACHE_TYPE = "q8_0";
        OLLAMA_CONTEXT_LENGTH = "32768";
      };

      loadModels = [
        "qwen3.5:9b"
        "gemma4:12b"
        "fredrezones55/Gemma-4-Uncensored-HauhauCS-Aggressive:e4b"
      ];
    };
  };
}
