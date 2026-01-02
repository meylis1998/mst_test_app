import 'package:mst_test_app/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:mst_test_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._localDatasource);

  final OnboardingLocalDatasource _localDatasource;

  @override
  Future<bool> isOnboardingCompleted() {
    return _localDatasource.isOnboardingCompleted();
  }

  @override
  Future<void> completeOnboarding() {
    return _localDatasource.completeOnboarding();
  }
}
