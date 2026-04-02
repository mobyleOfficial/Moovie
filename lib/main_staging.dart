import 'package:moovie/config/app_config.dart';
import 'package:moovie/main.dart';

void main() {
  AppConfig.instance = const AppConfig(
    flavor: AppFlavor.staging,
    backendUrl: 'https://staging.your-backend.com',
  );
  mainApp();
}
