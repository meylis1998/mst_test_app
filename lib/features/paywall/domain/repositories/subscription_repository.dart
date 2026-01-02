import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';

abstract class SubscriptionRepository {
  List<SubscriptionPlan> getSubscriptionPlans();

  Future<bool> isSubscribed();

  Future<SubscriptionPlanType?> getSubscriptionPlanType();

  Future<void> purchaseSubscription(SubscriptionPlanType planType);
}
