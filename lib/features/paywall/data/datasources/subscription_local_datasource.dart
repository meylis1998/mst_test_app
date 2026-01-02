import 'package:mst_test_app/core/constants/app_constants.dart';
import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/shared/data/datasources/local_storage.dart';

abstract class SubscriptionLocalDatasource {
  Future<bool> isSubscribed();

  Future<void> saveSubscription(SubscriptionPlanType planType);
}

class SubscriptionLocalDatasourceImpl implements SubscriptionLocalDatasource {
  SubscriptionLocalDatasourceImpl(this._localStorage);

  final LocalStorage _localStorage;

  @override
  Future<bool> isSubscribed() async {
    return _localStorage.getBool(AppConstants.subscriptionStatusKey) ?? false;
  }

  @override
  Future<void> saveSubscription(SubscriptionPlanType planType) async {
    await _localStorage.setBool(AppConstants.subscriptionStatusKey, value: true);
    await _localStorage.setString(
      AppConstants.subscriptionPlanKey,
      planType.name,
    );
  }
}
