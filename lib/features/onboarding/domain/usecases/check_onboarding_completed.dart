import 'package:mst_test_app/features/onboarding/domain/repositories/onboarding_repository.dart';

class CheckOnboardingCompleted {
  CheckOnboardingCompleted(this._repository);

  final OnboardingRepository _repository;

  Future<bool> call() => _repository.isOnboardingCompleted();
}
