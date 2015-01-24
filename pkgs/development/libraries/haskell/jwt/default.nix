# This file was auto-generated by cabal2nix. Please do NOT edit manually!

{ cabal, aeson, base64Bytestring, cryptohash, dataDefault
, httpTypes, HUnit, network, networkUri, QuickCheck, scientific
, semigroups, tasty, tastyHunit, tastyQuickcheck, tastyTh, text
, time, unorderedContainers, vector
}:

cabal.mkDerivation (self: {
  pname = "jwt";
  version = "0.5.3";
  sha256 = "1225fa53gghfpgwhr4x269a6kygfj39fh2qdapdi9mrrvlg302i4";
  buildDepends = [
    aeson base64Bytestring cryptohash dataDefault httpTypes network
    networkUri scientific semigroups text time unorderedContainers
    vector
  ];
  testDepends = [
    aeson base64Bytestring cryptohash dataDefault httpTypes HUnit
    network networkUri QuickCheck scientific semigroups tasty
    tastyHunit tastyQuickcheck tastyTh text time unorderedContainers
    vector
  ];
  meta = {
    homepage = "https://bitbucket.org/ssaasen/haskell-jwt";
    description = "JSON Web Token (JWT) decoding and encoding";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
