const APP_ID = "myviva-ynhp0cwdqpkdgq";

enum Environment {
  DEV,
  STAG,
  PROD,
}

class Constants {
  static Map<String, dynamic>? config;

  static void setEnvironment(Environment env) {
    switch (env) {
      case Environment.DEV:
        config = Config.debugConstants;
        break;
      case Environment.STAG:
        config = Config.stagConstants;
        break;
      case Environment.PROD:
        config = Config.prodConstants;
        break;
    }
  }

  static String get baseUrl => config?[Config.baseUrl];
}

class Config {
  static const String baseUrl = "baseUrl";

  static Map<String, dynamic> debugConstants = {
    baseUrl: "https://vivahealth-api.gits.app/",
  };
  static Map<String, dynamic> stagConstants = {
    baseUrl: "https://va-api-stag.vivahealth.co.id/",
  };
  static Map<String, dynamic> prodConstants = {
    baseUrl: "https://shop-api.vivahealth.co.id/",
  };
}

class ConfigEnvironment {
  static const String debugConstants = 'https://vivahealth-api.gits.app/';
  static const String stagConstants = 'https://va-api-stag.vivahealth.co.id/';
  static const String prodConstants = 'https://shop-api.vivahealth.co.id/';
}
