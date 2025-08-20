enum Flavors { dev, prod }

class Flavor {
  static Flavors appFlavor = Flavors.dev;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavors.dev:
        return 'Flutter Integration Test Dev';
      case Flavors.prod:
        return 'Flutter Integration Test';
    }
  }

  static bool isProduction() => appFlavor == Flavors.prod;
  static bool isDevelopment() => appFlavor == Flavors.dev;
}
