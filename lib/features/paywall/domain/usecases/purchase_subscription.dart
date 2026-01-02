import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';

class PurchaseSubscription {
  PurchaseSubscription(this._repository);

  final SubscriptionRepository _repository;

  Future<void> call(SubscriptionPlanType planType) =>
      _repository.purchaseSubscription(planType);
}
