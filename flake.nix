{
  description = "Xjle NixOS";

  outputs =
    { self, ... }@args:
    let
      inputs = (import ./.tack) { overrides = args.tackOverrides or { }; };
    in
      inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
}
