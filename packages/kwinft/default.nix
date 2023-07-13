{ mkDerivation, lib, fetchFromGitLab, extra-cmake-modules, wrapQtAppsHook
, kdoctools, plasma-framework, qtx11extras, kidletime, kcmutils, knewstuff
, kdecoration, kscreenlocker, wrapland, disman, kdisplay, wayland, libinput
, wlroots, xcb-util-cursor, pixman, epoxy, breeze-qt5, libcap
, libqaccessibilityclient, xwayland, libICE, libSM, kirigami2, xorg, valgrind
, qtdeclarative, mesa, vulkan-loader, seatd }:

mkDerivation rec {
  pname = "kwinft";
  version = "5.27.0";

  src = fetchFromGitLab {
    owner = "kwinft";
    repo = "kwinft";
    rev = "kwinft@5.27.0";
    sha256 = "0asy6z4crcclbq5r30mid6rp5xyzq67a4i2sb385m0yiwcd4h91d";
  };

  outputs = [ "out" "dev" ];

  patches = [
    ./follow-symlinks.patch
    ./Lower-CAP_SYS_NICE-from-the-ambient-set.patch
    ./plugins-qpa-allow-using-nixos-wrapper.patch
    ./xwayland.patch
  ];

  postPatch = ''
    patchShebangs effect/effects/strip-effect-metadata.py
    # TODO: add a patch if this is my fault, open an issue if it's their fault
    sed -i '540i \ \ \ \ KF5::Plasma' CMakeLists.txt
  '';

  nativeBuildInputs = [ extra-cmake-modules wrapQtAppsHook kdoctools ];

  buildInputs = [
    breeze-qt5
    disman
    epoxy
    kcmutils
    kdecoration
    kdisplay
    kidletime
    kirigami2
    knewstuff
    kscreenlocker
    libICE
    libSM
    libcap
    libinput
    libqaccessibilityclient
    mesa
    pixman
    plasma-framework
    qtdeclarative
    qtx11extras
    seatd
    valgrind
    vulkan-loader
    wayland
    wlroots
    wrapland
    xcb-util-cursor
    xorg.libXdmcp
    xorg.xcbutilerrors
    xwayland
  ];

  CXXFLAGS = [ ''-DNIXPKGS_XWAYLAND=\"${lib.getBin xwayland}/bin/Xwayland\"'' ];

  meta = with lib; {
    description = "Qt/C++ library wrapping libwayland";
    inherit (src.meta) homepage;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
}
