import 'package:common/common.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:muuvie/config/app_config.dart';
import 'package:muuvie/di/injection.dart';
import 'package:muuvie/routes/app_router.dart';
import 'package:user_activities/user_activities.dart';
import 'package:movies/movies.dart';
import 'package:path_provider/path_provider.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  AppConfig.instance = AppConfig.fromEnvironment();
  mainApp();
}

Future<void> mainApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Workmanager().initialize(callbackDispatcher);
  final appDir = await getApplicationDocumentsDirectory();
  final store = openStore(directory: '${appDir.path}/objectbox');
  configureDependencies(store: store);
  AuthGate.configure(loginRoute: const AuthFlowRoute());
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
      theme: MuuvieTheme.light,
      darkTheme: MuuvieTheme.dark,
      routerConfig: _appRouter.config(),
    );
  }
}
