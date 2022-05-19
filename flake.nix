{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=945ec49";
  outputs = { nixpkgs, flake-utils, self }:
    let
      ghc-version = "ghc8107";
      mkTetris = hkgs: import ./default.nix { inherit ghc-version hkgs; };
    in flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = self.packages.${system}.default;
      # defaultPackage is deprecated as of Nix 2.7.0
      packages = rec {
        default = tetris;
        tetris = mkTetris
          nixpkgs.legacyPackages.${system}.haskell.packages.${ghc-version};
      };
    }) // {
      overlays = {
        default = self.overlays.tetris-locked;
        tetris-locked = final: prev: {
          tetris = self.packages.${final.system}.default;
        };
        tetris = final: prev: {
          tetris = mkTetris final.haskell.packages.${ghc-version};
        };
      };
    };
}
