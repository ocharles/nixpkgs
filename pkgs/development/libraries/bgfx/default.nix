{ stdenv, fetchgit, genie, xproto, libX11, mesa }:

stdenv.mkDerivation {
  name = "bgfx";
  srcs = [
    (fetchgit {
      url = https://github.com/bkaradzic/bgfx.git;
      rev = "98b54dffd2621f7fd42e8c75cdd731f721a7648e";
      sha256 = "130mv71nfm4b5gzrvsl8kx7r6qsp11i0qildv21nav0n4fwpg915";
    })
    (fetchgit {
      url = https://github.com/bkaradzic/bx;
      rev = "9483ec326d8391fcdcf95be01a86cd95f4316191";
      sha256 = "c14376bb8276d2dd0d036a33bc10415fe3e1684d2c5b6d814a3b41f90c330f4b";
    })
  ];
  setSourceRoot = ''
    mv bgfx-* bgfx
    mv bx-* bx
    sourceRoot=bgfx
  '';
  patchPhase = ''
    sed -i "s|GENIE=.*|GENIE=${genie}/bin/genie|" makefile
  '';
  buildInputs = [ libX11 xproto mesa ];
  configurePhase = ''
    make all
  '';
  installPhase = ''
    mkdir -p $out/lib $out $out/lib/pkgconfig $out/include
    cp -r ../bx/include/* $out/include/
    cp -r include/bgfx $out/include/bgfx
    cp .build/linux64_gcc/bin/libbgfxRelease.a $out/lib/libbgfx.a
    cp .build/linux64_gcc/bin/libbgfx-shared-libRelease.so $out/lib/libbgfx.so
    cat > $out/lib/pkgconfig/bgfx.pc <<EOF
    prefix=$out
    exec_prefix=\''${prefix}
    libdir=\''${exec_prefix}/lib
    includedir=\''${prefix}/include

    Name: bgfx
    Description: Cross-platform, graphics API agnostic, "Bring Your Own Engine/Framework" style rendering library.
    Version: 1.0.0
    Requires:
    Conflicts:
    Libs: -L\''${libdir} -Wl,-rpath,\''${libdir} -lbgfx
    Cflags: -I\''${includedir}
    EOF
  '';
  buildPhase = ''
    make linux-release64
  '';
}
