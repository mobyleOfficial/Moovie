import 'package:moovie/config/app_config.dart';
import 'package:moovie/main.dart';

void main() {
  AppConfig.instance = const AppConfig(
    flavor: AppFlavor.dev,
    backendUrl: 'https://dev.your-backend.com',
  );
  mainApp();
}
