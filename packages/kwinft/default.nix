{ mkDerivation
, lib
, fetchFromGitLab
, extra-cmake-modules
, kdoctools
, fetchpatch
, libepoxy
, lcms2
, libICE
, libSM
, libcap
, libdrm
, libinput
, libxkbcommon
, mesa
, pipewire
, udev
, wayland
, xcb-util-cursor
, xwayland
, plasma-wayland-protocols
, wayland-protocols
, libxcvt
, qtdeclarative
, qtmultimedia
, qtquickcontrols2
, qtscript
, qtsensors
, qtvirtualkeyboard
, qtx11extras
, breeze-qt5
, kactivities
, kcompletion
, kcmutils
, kconfig
, kconfigwidgets
, kcoreaddons
, kcrash
, kdeclarative
, kdecoration
, kglobalaccel
, ki18n
, kiconthemes
, kidletime
, kinit
, kio
, knewstuff
, knotifications
, kpackage
, krunner
, kscreenlocker
, kservice
, kwayland
, kwidgetsaddons
, kwindowsystem
, kxmlgui
, plasma-framework
, libqaccessibilityclient
, kdisplay
, wrapland
, disman
, wlroots
, pixman
, kirigami2
, libXdmcp
, xcbutilerrors
, valgrind
, vulkan-loader
, seatd
}:

# TODO (ttuegel): investigate qmlplugindump failure

mkDerivation {
  pname = "kwinft";
  version = "5.27.0";

  src = fetchFromGitLab {
    owner = "kwinft";
    repo = "kwinft";
    rev = "kwinft@5.27.0";
    sha256 = "0asy6z4crcclbq5r30mid6rp5xyzq67a4i2sb385m0yiwcd4h91d";
  };

  nativeBuildInputs = [ extra-cmake-modules kdoctools ];
  buildInputs = [
    libepoxy
    lcms2
    libICE
    libSM
    libcap
    libdrm
    libinput
    libxkbcommon
    mesa
    pipewire
    udev
    wayland
    xcb-util-cursor
    xwayland
    libxcvt
    plasma-wayland-protocols
    wayland-protocols

    qtdeclarative
    qtmultimedia
    qtquickcontrols2
    qtscript
    qtsensors
    qtvirtualkeyboard
    qtx11extras

    breeze-qt5
    kactivities
    kcmutils
    kcompletion
    kconfig
    kconfigwidgets
    kcoreaddons
    kcrash
    kdeclarative
    kdecoration
    kglobalaccel
    ki18n
    kiconthemes
    kidletime
    kinit
    kio
    knewstuff
    knotifications
    kpackage
    krunner
    kscreenlocker
    kservice
    kwayland
    kwidgetsaddons
    kwindowsystem
    kxmlgui
    plasma-framework
    libqaccessibilityclient

    kdisplay    
    wrapland
    disman
    wlroots
    pixman
    kirigami2
    libXdmcp
    xcbutilerrors
    valgrind
    vulkan-loader
    seatd
  ];
  outputs = [ "out" "dev" ];

  postPatch = ''
    patchShebangs effect/effects/strip-effect-metadata.py
    # TODO: add a patch if this is my fault, open an issue if it's their fault
    sed -i '540i \ \ \ \ KF5::Plasma' CMakeLists.txt

    # /build/source/render/backend/wlroots/texture_update.h:24:10: fatal error: drm_fourcc.h: No such file or directory
    #    24 | #include <drm_fourcc.h>
    #       |          ^~~~~~~~~~~~~~
    substituteInPlace render/backend/wlroots/texture_update.h \
      --replace "<drm_fourcc.h>" "<libdrm/drm_fourcc.h>"
  '';

  patches = [
    ./follow-symlinks.patch
    ./Lower-CAP_SYS_NICE-from-the-ambient-set.patch
    ./plugins-qpa-allow-using-nixos-wrapper.patch
    ./xwayland.patch
  ];

  CXXFLAGS = [
    ''-DNIXPKGS_XWAYLAND=\"${lib.getExe xwayland}\"''
  ];

  postInstall = ''
    # Some package(s) refer to these service types by the wrong name.
    # I would prefer to patch those packages, but I cannot find them!
    ln -s ''${!outputBin}/share/kservicetypes5/kwineffect.desktop \
          ''${!outputBin}/share/kservicetypes5/kwin-effect.desktop
    ln -s ''${!outputBin}/share/kservicetypes5/kwinscript.desktop \
          ''${!outputBin}/share/kservicetypes5/kwin-script.desktop
  '';

  meta = with lib; {
    description = "Wayland compositor and X11 window manager";
    inherit (src.meta) homepage;
    license = licenses.lgpl21Plus;
    platforms = platforms.linux;
  };
}
