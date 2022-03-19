{
  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?ref=945ec49";
  outputs = { nixpkgs, flake-utils, self }:
    let ghc-version = "ghc8107";
    in flake-utils.lib.eachDefaultSystem (system: {
      defaultPackage = self.packages.${system}.default;
        # defaultPackage is deprecated as of Nix 2.7.0
      packages = rec {
        default = tetris;
        tetris = import ./default.nix {
          hkgs = nixpkgs.legacyPackages.${system}.haskell.packages.${ghc-version};
          inherit ghc-version;
        };
      };
    });
}
