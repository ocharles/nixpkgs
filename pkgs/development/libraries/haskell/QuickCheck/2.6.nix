{ cabal, random }:

cabal.mkDerivation (self: {
  pname = "QuickCheck";
  version = "2.6";
  sha256 = "03cp7mshjy2yrg31i13b9kmc2a6lrmrbl1sh9s8lswcj305c00c0";
  buildDepends = [ random ];
  meta = {
    homepage = "http://code.haskell.org/QuickCheck";
    description = "Automatic testing of Haskell programs";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.andres ];
  };
})
