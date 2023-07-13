self: super: {
  plasma5Packages = super.plasma5Packages.overrideScope' (self: super: {
    plasma5 = super.plasma5.overrideScope' (self: super: {
      wrapland = self.callPackage ./wrapland { };
      disman = self.callPackage ./disman { };
      kdisplay = self.callPackage ./kdisplay { };
      kwinft = self.callPackage ./kwinft { };
      kwin = self.kwinft;
    });
  });
}
