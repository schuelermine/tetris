{ ghc-version ? "ghc8107"
, hkgs ? (import <nixpkgs> { }).haskell.packages.${ghc-version} }:
hkgs.callPackage ({ mkDerivation, base, brick, containers, directory, filepath
  , lens, lib, linear, optparse-applicative, random, transformers, vty }:
  mkDerivation {
    pname = "tetris";
    version = "0.1.4.0";
    src = ./.;
    isLibrary = true;
    isExecutable = true;
    libraryHaskellDepends =
      [ base brick containers lens linear random transformers vty ];
    executableHaskellDepends = [ base directory filepath optparse-applicative ];
    homepage = "https://github.com/samtay/tetris#readme";
    license = lib.licenses.bsd3;
  }) { }
