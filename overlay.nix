final: prev: {
  plasma5Packages = prev.plasma5Packages.overrideScope' (final: prev: {
    plasma5 = prev.plasma5.overrideScope' (final: prev: {
      wrapland = final.callPackage ./wrapland { };
      disman = final.callPackage ./disman { };
      kdisplay = final.callPackage ./kdisplay { };
      kwinft = final.callPackage ./kwinft { };
      kwin = final.kwinft;
    });
  });
}
