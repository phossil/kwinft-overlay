final: prev: {
  plasma5Packages = prev.plasma5Packages.overrideScope' (final: prev: {
    plasma5 = prev.plasma5.overrideScope' (final: prev: {
      wrapland = final.callPackage ./packages/wrapland { };
      disman = final.callPackage ./packages/disman { };
      kdisplay = final.callPackage ./packages/kdisplay { };
      kwinft = final.callPackage ./packages/kwinft { };
      kwin = final.kwinft;
    });
  });
}