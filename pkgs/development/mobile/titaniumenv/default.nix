{pkgs, pkgs_i686, xcodeVersion ? "5.0"}:

rec {
  androidenv = pkgs.androidenv;

  xcodeenv = if pkgs.stdenv.system == "x86_64-darwin" then pkgs.xcodeenv.override {
    version = xcodeVersion;
  } else null;
  
  titaniumsdk = import ./titaniumsdk.nix {
    inherit (pkgs) stdenv fetchurl unzip makeWrapper python jdk;
  };
  
  buildApp = import ./build-app.nix {
    inherit (pkgs) stdenv jdk;
    inherit (androidenv) androidsdk;
    inherit (xcodeenv) xcodewrapper;
    inherit titaniumsdk;
  };
}
