import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moovie/config/app_config.dart';
import 'package:moovie/di/injection.dart';
import 'package:moovie/routes/app_router.dart';

void main() {
  AppConfig.instance = const AppConfig(
    flavor: AppFlavor.prod,
    backendUrl: 'https://your-backend.com',
  );
  mainApp();
}

void mainApp() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  String get appTitle => AppConfig.instance.appName;

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: appTitle,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: MoovieTheme.light,
      darkTheme: MoovieTheme.dark,
      routerConfig: _appRouter.config(),
    );
  }
}
