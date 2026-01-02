import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';

class GetSubscriptionPlans {
  GetSubscriptionPlans(this._repository);

  final SubscriptionRepository _repository;

  List<SubscriptionPlan> call() => _repository.getSubscriptionPlans();
}
