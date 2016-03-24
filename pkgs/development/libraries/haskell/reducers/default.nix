# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, comonad, fingertree, hashable, keys, pointed
, semigroupoids, semigroups, text, transformers
, unorderedContainers
}:

cabal.mkDerivation (self: {
  pname = "reducers";
  version = "3.10.3";
  sha256 = "0hi77mgc2f38y0xfykn7x6gdl6xg710skpx4z76s8c0wwnd28pr6";
  buildDepends = [
    comonad fingertree hashable keys pointed semigroupoids semigroups
    text transformers unorderedContainers
  ];
  jailbreak = true;
  meta = {
    homepage = "http://github.com/ekmett/reducers/";
    description = "Semigroups, specialized containers and a general map/reduce framework";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
