{ stdenv, lib, fetchFromGitLab, extra-cmake-modules, wrapQtAppsHook, qtx11extras
, plasma-framework, wrapland }:

stdenv.mkDerivation rec {
  pname = "disman";
  version = "5.27.0";

  src = fetchFromGitLab {
    owner = "kwinft";
    repo = "disman";
    rev = "disman@0.527.0";
    sha256 = "0zx1md551iypkqh1g39rhwyndca5yh7rck3891djgq2y7xn31d68";
  };

  nativeBuildInputs = [ extra-cmake-modules wrapQtAppsHook ];

  buildInputs = [ qtx11extras plasma-framework wrapland ];

  meta = with lib; {
    description = "Qt/C++ library wrapping libwayland";
    inherit (src.meta) homepage;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
}
