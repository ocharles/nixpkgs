{ stdenv, fetchurl, zlib, readline }:

let
  version = "9.2.6";

  osspUuid = stdenv.mkDerivation rec {
    name = "ossp-uuid-1.6.2";
    src = fetchurl {
      url = "ftp://ftp.ossp.org/pkg/lib/uuid/uuid-1.6.2.tar.gz";
      sha256 = "1c6m1wgq0cpzpmjlff8dyz9sq9s41vsj6i42hsv8npxabci1b9hi";
    };
  };
  
in

stdenv.mkDerivation rec {
  name = "postgresql-${version}";

  src = fetchurl {
    url = "mirror://postgresql/source/v${version}/${name}.tar.bz2";
    sha256 = "11pqy0f2bx211ja4hkqpkrskyqh4idp9bhnvjfpphmkflr9q1aab";
  };

  buildInputs = [ zlib readline osspUuid ];

  enableParallelBuilding = true;

  configureFlags = [ "--with-ossp-uuid" ];

  makeFlags = [ "world" ];

  patches = [ ./disable-resolve_symlinks.patch ];

  installTargets = [ "install-world" ];

  LC_ALL = "C";

  passthru = {
    inherit readline;
    psqlSchema = "9.2";
  };

  meta = {
    homepage = http://www.postgresql.org/;
    description = "A powerful, open source object-relational database system";
    license = "bsd";
  };
}