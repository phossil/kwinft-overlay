{ stdenv, lib, fetchFromGitLab, extra-cmake-modules, wrapQtAppsHook, disman
, plasma-framework, qtsensors, kcmutils }:

stdenv.mkDerivation rec {
  pname = "kdisplay";
  version = "5.27.0";

  src = fetchFromGitLab {
    owner = "kwinft";
    repo = "kdisplay";
    rev = "kdisplay@5.27.0";
    sha256 = "02ghmcnjdrp7vv91qdyikcj9cl8kdf3cvsgjnk5i0x4n2plmcm3r";
  };

  nativeBuildInputs = [ extra-cmake-modules wrapQtAppsHook ];

  buildInputs = [ disman plasma-framework qtsensors kcmutils ];

  meta = with lib; {
    description = "Qt/C++ library wrapping libwayland";
    inherit (src.meta) homepage;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
}
