# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, cmdtheline, filepath, haskeline, monadUnify, mtl, parsec
, patternArrows, time, transformers, unorderedContainers
, utf8String, xdgBasedir
}:

cabal.mkDerivation (self: {
  pname = "purescript";
  version = "0.5.7.1";
  sha256 = "1xjihv7lq5b2cw44jhxwzr21749gayqfiqjkryz6z9p820hg1zzv";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    cmdtheline filepath haskeline monadUnify mtl parsec patternArrows
    time transformers unorderedContainers utf8String xdgBasedir
  ];
  testDepends = [ filepath mtl parsec transformers utf8String ];
  doCheck = false;
  meta = {
    homepage = "http://www.purescript.org/";
    description = "PureScript Programming Language Compiler";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
