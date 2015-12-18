{ stdenv, fetchgit, genie }:
stdenv.mkDerivation {
  name = "bx";
  src = fetchgit {
    url = https://github.com/bkaradzic/bx;
    rev = "9483ec326d8391fcdcf95be01a86cd95f4316191";
    sha256 = "c14376bb8276d2dd0d036a33bc10415fe3e1684d2c5b6d814a3b41f90c330f4b";
  };
  patchPhase = ''
    sed -i "s|GENIE=.*|GENIE=${genie}/bin/genie|" makefile
  '';
  configurePhase = ''
    make all
  '';
  buildPhase = ''
    make linux-release64
  '';
  installPhase = ''
    mkdir -p $out/lib
    cp .build/linux64_gcc/bin/libbxRelease.a $out/lib
  '';
}
