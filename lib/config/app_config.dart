enum AppFlavor { dev, staging, prod }

class AppConfig {
  final AppFlavor flavor;
  final String backendUrl;

  const AppConfig({
    required this.flavor,
    required this.backendUrl,
  });

  static late AppConfig instance;

  String get appName => switch (flavor) {
        AppFlavor.dev => 'MoovieDev',
        AppFlavor.staging => 'MoovieStg',
        AppFlavor.prod => 'Moovie',
      };
}
