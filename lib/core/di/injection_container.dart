import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:mst_test_app/core/network/api_client.dart';
import 'package:mst_test_app/core/network/interceptors/auth_interceptor.dart';
import 'package:mst_test_app/core/network/interceptors/logging_interceptor.dart';
import 'package:mst_test_app/core/network/network_info.dart';
import 'package:mst_test_app/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:mst_test_app/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mst_test_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mst_test_app/features/onboarding/domain/usecases/check_onboarding_completed.dart';
import 'package:mst_test_app/features/onboarding/domain/usecases/complete_onboarding.dart';
import 'package:mst_test_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:mst_test_app/features/paywall/data/datasources/subscription_local_datasource.dart';
import 'package:mst_test_app/features/paywall/data/repositories/subscription_repository_impl.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';
import 'package:mst_test_app/features/paywall/domain/usecases/get_subscription_plans.dart';
import 'package:mst_test_app/features/paywall/domain/usecases/purchase_subscription.dart';
import 'package:mst_test_app/features/paywall/presentation/bloc/paywall_bloc.dart';
import 'package:mst_test_app/shared/data/datasources/local_storage.dart';
import 'package:mst_test_app/shared/presentation/blocs/theme/theme_bloc.dart';

final sl = GetIt.instance;

Future<void> initDependencies() async {
  await _initExternal();

  _initCore();

  _initBlocs();

  _initFeatures();
}

Future<void> _initExternal() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton<SharedPreferences>(sharedPreferences);

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );
  sl.registerSingleton<FlutterSecureStorage>(secureStorage);

  sl.registerLazySingleton<InternetConnection>(InternetConnection.new);

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
  sl.registerLazySingleton<LocalStorage>(
    () => LocalStorageImpl(sl()),
  );

  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(sl()),
  );

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
  sl.registerFactory<ThemeBloc>(
    () => ThemeBloc(localStorage: sl()),
  );
}

void _initFeatures() {
  _initOnboarding();
  _initPaywall();
}

void _initOnboarding() {
  sl.registerLazySingleton<OnboardingLocalDatasource>(
    () => OnboardingLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => CheckOnboardingCompleted(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  sl.registerFactory<OnboardingBloc>(
    () => OnboardingBloc(completeOnboarding: sl()),
  );
}

void _initPaywall() {
  sl.registerLazySingleton<SubscriptionLocalDatasource>(
    () => SubscriptionLocalDatasourceImpl(sl()),
  );

  sl.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(() => GetSubscriptionPlans(sl()));
  sl.registerLazySingleton(() => PurchaseSubscription(sl()));

  sl.registerFactory<PaywallBloc>(
    () => PaywallBloc(
      getSubscriptionPlans: sl(),
      purchaseSubscription: sl(),
    ),
  );
}
