import 'package:get_it/get_it.dart';
import '../services/audio_service.dart';
import '../services/database_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  // Services
  getIt.registerLazySingleton<AudioService>(() => AudioService());
  getIt.registerLazySingleton<DatabaseService>(() => DatabaseService());
}
