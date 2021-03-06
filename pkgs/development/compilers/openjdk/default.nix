{ stdenv, fetchurl, unzip, zip, procps, coreutils, alsaLib, ant, freetype, cups
, which, jdk, nettools, libX11, libXt, libXext, libXrender, libXtst, libXi, libXinerama
, libXcursor, fontconfig, cpio, cacert, perl, setJavaClassPath }:

let

  /**
   * The JRE libraries are in directories that depend on the CPU.
   */
  architecture =
    if stdenv.system == "i686-linux" then
      "i386"
    else if stdenv.system == "x86_64-linux" then
      "amd64"
    else
      throw "openjdk requires i686-linux or x86_64 linux";

  update = "40";

  build = "43";

in

stdenv.mkDerivation rec {
  name = "openjdk-7u${update}b${build}";

  src = fetchurl {
    url = http://www.java.net/download/openjdk/jdk7u40/promoted/b43/openjdk-7u40-fcs-src-b43-26_aug_2013.zip;
    sha256 = "15h5nmbw6yn5596ccakqdbs0vd8hmslsfg5sfk8wmjvn31bfmy00";
  };

  outputs = [ "out" "jre" ];

  buildInputs =
    [ unzip procps ant which zip cpio nettools alsaLib
      libX11 libXt libXext libXrender libXtst libXi libXinerama libXcursor
      fontconfig perl
    ];

  NIX_LDFLAGS = "-lfontconfig -lXcursor -lXinerama";

  postUnpack = ''
    sed -i -e "s@/usr/bin/test@${coreutils}/bin/test@" \
      -e "s@/bin/ls@${coreutils}/bin/ls@" \
      openjdk/hotspot/make/linux/makefiles/sa.make

    sed -i "s@/bin/echo -e@${coreutils}/bin/echo -e@" \
      openjdk/{jdk,corba}/make/common/shared/Defs-utils.gmk
  '';

  patches = [ ./cppflags-include-fix.patch ];

  NIX_NO_SELF_RPATH = true;

  makeFlags = [
    "SORT=${coreutils}/bin/sort"
    "ALSA_INCLUDE=${alsaLib}/include/alsa/version.h"
    "FREETYPE_HEADERS_PATH=${freetype}/include"
    "FREETYPE_LIB_PATH=${freetype}/lib"
    "MILESTONE=release"
    "BUILD_NUMBER=b${build}"
    "CUPS_HEADERS_PATH=${cups}/include"
    "USRBIN_PATH="
    "COMPILER_PATH="
    "DEVTOOLS_PATH="
    "UNIXCOMMAND_PATH="
    "BOOTDIR=${jdk}"
    "UNLIMITED_CRYPTO=1"
  ];

  configurePhase = "true";

  installPhase = ''
    mkdir -p $out/lib/openjdk $out/share $jre/lib/openjdk

    cp -av build/*/j2sdk-image/* $out/lib/openjdk

    # Move some stuff to top-level.
    mv $out/lib/openjdk/include $out/include
    mv $out/lib/openjdk/man $out/share/man

    # Remove some broken manpages.
    rm -rf $out/share/man/ja*

    # Remove crap from the installation.
    rm -rf $out/lib/openjdk/demo $out/lib/openjdk/sample

    # Move the JRE to a separate output.
    mv $out/lib/openjdk/jre $jre/lib/openjdk/
    ln -s $jre/lib/openjdk/jre $out/lib/openjdk/jre

    # Remove duplicate binaries.
    for i in $(cd $out/lib/openjdk/bin && echo *); do
      if cmp -s $out/lib/openjdk/bin/$i $jre/lib/openjdk/jre/bin/$i; then
        ln -sfn $jre/lib/openjdk/jre/bin/$i $out/lib/openjdk/bin/$i
      fi
    done

    # Generate certificates.
    pushd $jre/lib/openjdk/jre/lib/security
    rm cacerts
    perl ${./generate-cacerts.pl} $jre/lib/openjdk/jre/bin/keytool ${cacert}/etc/ca-bundle.crt
    popd

    ln -s $out/lib/openjdk/bin $out/bin
    ln -s $jre/lib/openjdk/jre/bin $jre/bin
  ''; # */

  # FIXME: this is unnecessary once the multiple-outputs branch is merged.
  preFixup = ''
    prefix=$jre stripDirs "$stripDebugList" "''${stripDebugFlags:--S}"
    patchELF $jre
    propagatedNativeBuildInputs+=" $jre"

    # Propagate the setJavaClassPath setup hook from the JRE so that
    # any package that depends on the JRE has $CLASSPATH set up
    # properly.
    mkdir -p $jre/nix-support
    echo -n "${setJavaClassPath}" > $jre/nix-support/propagated-native-build-inputs

    # Set JAVA_HOME automatically.
    mkdir -p $out/nix-support
    cat <<EOF > $out/nix-support/setup-hook
    if [ -z "\$JAVA_HOME" ]; then export JAVA_HOME=$out/lib/openjdk; fi
    EOF
  '';

  meta = {
    homepage = http://openjdk.java.net/;
    license = "GPLv2";
    description = "The open-source Java Development Kit";
    maintainers = [ stdenv.lib.maintainers.shlevy ];
    platforms = stdenv.lib.platforms.linux;
  };

  passthru = { inherit architecture; };
}
