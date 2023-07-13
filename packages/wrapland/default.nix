{ stdenv, lib, fetchFromGitLab, extra-cmake-modules, wrapQtAppsHook, wayland
, wayland-protocols }:

stdenv.mkDerivation rec {
  pname = "wrapland";
  version = "5.27.0";

  src = fetchFromGitLab {
    owner = "kwinft";
    repo = "wrapland";
    rev = "wrapland@0.527.0";
    sha256 = "13gvhc2pgkrcq2h04f3kxp8dj358kg9kdnf7a2b1i8x14aa7ijac";
  };

  nativeBuildInputs = [ extra-cmake-modules wrapQtAppsHook ];

  buildInputs = [ wayland wayland-protocols ];

  meta = with lib; {
    description = "Qt/C++ library wrapping libwayland";
    inherit (src.meta) homepage;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
}
