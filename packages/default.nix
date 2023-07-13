{ pkgs, makeScope, libsForQt5 }:

makeScope libsForQt5.newScope (self: with self; {
  disman = callPackage ./disman { };
  kdisplay = callPackage ./kdisplay { };
  kwinft = callPackage ./kwinft {
    wlroots = pkgs.wlroots_0_16;
  };
  wrapland = callPackage ./wrapland { };
})
