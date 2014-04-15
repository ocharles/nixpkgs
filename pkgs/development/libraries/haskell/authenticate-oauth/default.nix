{ fetchgit
, cabal, base64Bytestring, blazeBuilder, blazeBuilderConduit
, conduit, cryptoPubkeyTypes, dataDefault, httpConduit, httpTypes
, monadControl, random, resourcet, RSA, SHA, time, transformers
}:

cabal.mkDerivation (self: {
  pname = "authenticate-oauth";
  version = "1.4.0.8";
  src = fetchgit {
    url = git://github.com/ocharles/authenticate;
    sha256 = "0ln3bbqy2q6cdx5rw2yh9wg5nr47yblklrkvk4ghkj1fhmyimdpr";
    rev = "332e06f5933c6b75a073349476bfae9e8d263642";
  };
  setSourceRoot = "sourceRoot=git-export/authenticate-oauth";
  buildDepends = [
    base64Bytestring blazeBuilder blazeBuilderConduit conduit
    cryptoPubkeyTypes dataDefault httpConduit httpTypes monadControl
    random resourcet RSA SHA time transformers
  ];
  meta = {
    homepage = "http://github.com/yesodweb/authenticate";
    description = "Library to authenticate with OAuth for Haskell web applications";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.ocharles ];
  };
})
