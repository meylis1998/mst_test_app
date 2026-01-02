import 'package:mst_test_app/features/paywall/data/datasources/subscription_local_datasource.dart';
import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';

class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._localDatasource);

  final SubscriptionLocalDatasource _localDatasource;

  @override
  List<SubscriptionPlan> getSubscriptionPlans() {
    return const [
      SubscriptionPlan(
        type: SubscriptionPlanType.monthly,
        name: 'Monthly',
        price: r'$9.99',
        period: 'per month',
      ),
      SubscriptionPlan(
        type: SubscriptionPlanType.yearly,
        name: 'Yearly',
        price: r'$59.99',
        period: 'per year',
        discount: 'Save 50%',
      ),
    ];
  }

  @override
  Future<bool> isSubscribed() {
    return _localDatasource.isSubscribed();
  }

  @override
  Future<SubscriptionPlanType?> getSubscriptionPlanType() {
    return _localDatasource.getSubscriptionPlanType();
  }

  @override
  Future<void> purchaseSubscription(SubscriptionPlanType planType) async {
    await Future<void>.delayed(const Duration(seconds: 1));
    await _localDatasource.saveSubscription(planType);
  }
}
