{ cabal, blazeBuilder, enumerator, ioStreams, mtl, snapCore
, snapServer, websockets
}:

cabal.mkDerivation (self: {
  pname = "websockets-snap";
  version = "0.8.2.1";
  sha256 = "13q1vrrcka91w9yad3jw1w68hp59n851hkn9a3hylw0cqs7008az";
  buildDepends = [
    blazeBuilder enumerator ioStreams mtl snapCore snapServer
    websockets
  ];
  meta = {
    description = "Snap integration for the websockets library";
    license = self.stdenv.lib.licenses.bsd3;
    platforms = self.ghc.meta.platforms;
    maintainers = [ self.stdenv.lib.maintainers.ocharles ];
  };
})
