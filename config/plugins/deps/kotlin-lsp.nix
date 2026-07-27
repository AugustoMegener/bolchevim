{
  stdenv,
  stdenvNoCC,
  fetchzip,
  makeWrapper,
  autoPatchelfHook,
  lib,
  wayland,
  libxkbcommon,
  libX11,
  libXext,
  libXi,
  libXrender,
  libXtst,
  freetype,
  zlib,
  alsa-lib,
  ...
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "kotlin-lsp";
  version = "262.8190.0";

  src = fetchzip {
    url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/262.8190.0/kotlin-server-262.8190.0.tar.gz";
    sha256 = "sha256-tGqU5h1IKi2fZy+oBN/GjujbIMMg4AKlbBKw3D9NU5Y=";
    stripRoot = false;
  };

  nativeBuildInputs = [
    makeWrapper
    autoPatchelfHook
  ];

  buildInputs = [
    stdenv.cc.cc.lib
    wayland
    libxkbcommon
    libX11
    libXext
    libXi
    libXrender
    libXtst
    freetype
    zlib
    alsa-lib
  ];

installPhase = ''
  mkdir -p $out/share
  mkdir -p $out/bin

  mv kotlin-server-${finalAttrs.version} $out/share/

  chmod +x $out/share/kotlin-server-${finalAttrs.version}/bin/intellij-server

  makeWrapper \
    $out/share/kotlin-server-${finalAttrs.version}/bin/intellij-server \
    $out/bin/intellij-server \
    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath finalAttrs.buildInputs}
'';
})
