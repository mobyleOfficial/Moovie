import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:objectbox/objectbox.dart';

import 'package:moovie/di/injection.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({required Store store}) {
  getIt.registerSingleton<Store>(store);
  getIt.init();
}
