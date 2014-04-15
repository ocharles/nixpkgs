{ cabal, aeson, blazeBuilder, blazeHtml, blazeMarkup, exceptions
, hspec, httpTypes, HUnit, parsec, systemFileio, systemFilepath
, text, time, transformers, wai, waiAppStatic
}:

cabal.mkDerivation (self: {
  pname = "shakespeare";
  version = "2.0.0.1";
  sha256 = "0c8pkswfm2b940vxincivkk8ibpv13jvf3irk740lmlra0h8bp7a";
  isLibrary = true;
  isExecutable = true;
  buildDepends = [
    aeson blazeBuilder blazeHtml blazeMarkup exceptions httpTypes
    parsec systemFileio systemFilepath text time transformers wai
    waiAppStatic
  ];
  testDepends = [
    aeson blazeHtml blazeMarkup exceptions hspec HUnit parsec
    systemFileio systemFilepath text time transformers
  ];
  meta = {
    homepage = "http://www.yesodweb.com/book/shakespearean-templates";
    description = "A toolkit for making compile-time interpolated templates";
    license = self.stdenv.lib.licenses.mit;
    platforms = self.ghc.meta.platforms;
  };
})
