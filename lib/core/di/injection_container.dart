import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mst_test_app/core/network/api_client.dart';
import 'package:mst_test_app/core/network/interceptors/auth_interceptor.dart';
import 'package:mst_test_app/core/network/interceptors/logging_interceptor.dart';
import 'package:mst_test_app/core/network/network_info.dart';
import 'package:mst_test_app/shared/data/datasources/local_storage.dart';
import 'package:mst_test_app/shared/presentation/blocs/theme/theme_bloc.dart';

/// Global service locator instance.
final sl = GetIt.instance;

/// Initializes all dependencies.
Future<void> initDependencies() async {
  // External
  await _initExternal();

  // Core
  _initCore();

  // BLoCs
  _initBlocs();

  // Features
  _initFeatures();
}

Future<void> _initExternal() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  // FlutterSecureStorage
  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  // InternetConnectionChecker
  sl.registerLazySingleton<InternetConnection>(InternetConnection.new);

  // Logger
  sl.registerLazySingleton<Logger>(
    () => Logger(
      printer: PrettyPrinter(
        methodCount: 2,
        errorMethodCount: 8,
        lineLength: 120,
        colors: true,
        printEmojis: true,
      ),
    ),
  );
}

void _initCore() {
  // Local Storage
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(sl()),
  );

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

  // API Client
  sl.registerLazySingleton<ApiClient>(
    () => ApiClient(
      interceptors: [
        AuthInterceptor(sl()),
        LoggingInterceptor(sl()),
      ],
    ),
  );
}

void _initBlocs() {
  // Theme BLoC
  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(localStorage: sl()),
  );
}

void _initFeatures() {
  // Add feature-specific dependencies here
  // Example:
  // _initAuth();
  // _initHome();
  // _initSettings();
}
