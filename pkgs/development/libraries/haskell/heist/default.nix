{ cabal, aeson, attoparsec, blazeBuilder, blazeHtml, directoryTree
, dlist, errors, filepath, hashable, MonadCatchIOTransformers, mtl
, random, text, time, transformers, unorderedContainers, vector
, xmlhtml
}:

cabal.mkDerivation (self: {
  pname = "heist";
  version = "0.13.0.4";
  sha256 = "15iixsjlx3zd44dcdxla5pgpl16995pk9g34zjqynmhcj7sfv5as";
  buildDepends = [
    aeson attoparsec blazeBuilder blazeHtml directoryTree dlist errors
    filepath hashable MonadCatchIOTransformers mtl random text time
    transformers unorderedContainers vector xmlhtml
  ];
  meta = {
    homepage = "http://snapframework.com/";
    description = "An Haskell template system supporting both HTML5 and XML";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
  };
})
