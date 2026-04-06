import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:moovie/config/app_config.dart';
import 'package:moovie/di/injection.dart';
import 'package:moovie/routes/app_router.dart';
import 'package:movies/movies.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  AppConfig.instance = const AppConfig(
    flavor: AppFlavor.prod,
    backendUrl: 'https://your-backend.com',
  );
  mainApp();
}

Future<void> mainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDir = await getApplicationDocumentsDirectory();
  final store = await openStore(directory: '${appDir.path}/objectbox');
  configureDependencies(store: store);
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
