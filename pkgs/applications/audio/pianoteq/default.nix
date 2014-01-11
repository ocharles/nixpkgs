{ requireFile, stdenv, p7zip, libX11, libXext, alsaLib, freetype }:
stdenv.mkDerivation {
  name = "pianoteq-stage-4.5.4";

  buildInputs = [ p7zip ];

  src = requireFile {
    message = ''
      Please download Pianoteq and then use nix-prefetch-url
      file:///path/to/pianoteq.7z
    '';
    name = "pianoteq_stage_linux_v454.7z";
    sha256 = "17d0q4j8ccygya5rml2q5m49bqphd28w0vz48plxdyf3hbz6crif";
  };

  unpackPhase = ''
    mkdir $out
    cd $out
    7za x $src
  '';

  libPath = stdenv.lib.makeLibraryPath [ stdenv.gcc.gcc stdenv.gcc.libc ] 
    + ":" + stdenv.lib.makeLibraryPath [ libX11 libXext alsaLib freetype ];

  installPhase = ''
    patchelf --interpreter "$(cat $NIX_GCC/nix-support/dynamic-linker)" \
      --set-rpath $libPath \
      'Pianoteq 4 STAGE/amd64/Pianoteq 4 STAGE'
  '';

  phases = "unpackPhase installPhase";
}
