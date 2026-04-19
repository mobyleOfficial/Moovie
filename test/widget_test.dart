import 'package:flutter_test/flutter_test.dart';
import 'package:moovie/config/app_config.dart';
import 'package:common/common.dart';

void main() {
  test('placeholder smoke test', () {
    expect(1 + 1, equals(2));
  });

  test('AppConfig returns correct flavor', () {
    AppConfig.instance = const AppConfig(
      flavor: AppFlavor.dev,
      backendUrl: 'https://dev.example.com',
    );
    expect(AppConfig.instance.flavor, AppFlavor.dev);
  });

  test('AppConfig returns correct backend URL', () {
    AppConfig.instance = const AppConfig(
      flavor: AppFlavor.dev,
      backendUrl: 'https://api.example.com',
    );
    expect(AppConfig.instance.backendUrl, 'https://api.example.com');
  });
}
