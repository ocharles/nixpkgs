{ stdenv, fetchgit }:
stdenv.mkDerivation {
  name = "genie-349";
  src = fetchgit {
    url = https://github.com/bkaradzic/genie;
    rev = "3d4f244dc51151ae2cbd2c34c76342221016e499";
    sha256 = "e2466ec4b1396eebaa0cf2db68317304539d566ebc16100bc530fe3a5f2d946d";
  };
  installPhase = ''
    mkdir -p $out/bin
    find .
    cp bin/linux/genie $out/bin/
  '';
}
