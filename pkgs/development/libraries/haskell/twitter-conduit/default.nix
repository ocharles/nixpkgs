{ fetchgit
, cabal, aeson, attoparsec, attoparsecConduit, authenticateOauth
, conduit, dataDefault, doctest, failure, filepath, hlint
, httpClient, httpConduit, httpTypes, lens, liftedBase
, monadControl, monadLogger, resourcet, shakespeare, text, time
, transformers, transformersBase, twitterTypes
}:

cabal.mkDerivation (self: {
  pname = "twitter-conduit";
  version = "0.0.2.1";
  src = fetchgit {
    url = git://github.com/ocharles/twitter-conduit;
    sha256 = "0b5bfin8l71bj7gci6hhvavy1x6d1bwpjzsc19s58y7p1abalhxx";
  };
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson attoparsec attoparsecConduit authenticateOauth conduit
    dataDefault failure httpClient httpConduit httpTypes lens
    liftedBase monadControl monadLogger resourcet shakespeare text time
    transformers transformersBase twitterTypes
  ];
  testDepends = [ doctest filepath hlint ];
  meta = {
    homepage = "https://github.com/himura/twitter-conduit";
    description = "Twitter API package with conduit interface and Streaming API support";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.ocharles ];
  };
  doCheck = false;
})
