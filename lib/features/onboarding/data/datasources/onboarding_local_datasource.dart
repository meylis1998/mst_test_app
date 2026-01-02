import 'package:mst_test_app/core/constants/app_constants.dart';
import 'package:mst_test_app/shared/data/datasources/local_storage.dart';

abstract class OnboardingLocalDatasource {
  Future<bool> isOnboardingCompleted();

  Future<void> completeOnboarding();
}

class OnboardingLocalDatasourceImpl implements OnboardingLocalDatasource {
  OnboardingLocalDatasourceImpl(this._localStorage);

  final LocalStorage _localStorage;

  @override
  Future<bool> isOnboardingCompleted() async {
    return _localStorage.getBool(AppConstants.onboardingCompletedKey) ?? false;
  }

  @override
  Future<void> completeOnboarding() async {
    await _localStorage.setBool(AppConstants.onboardingCompletedKey, value: true);
  }
}
