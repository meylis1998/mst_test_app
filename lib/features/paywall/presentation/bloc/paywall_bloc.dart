import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/features/paywall/domain/usecases/get_subscription_plans.dart';
import 'package:mst_test_app/features/paywall/domain/usecases/purchase_subscription.dart';

part 'paywall_event.dart';
part 'paywall_state.dart';

class PaywallBloc extends Bloc<PaywallEvent, PaywallState> {
  PaywallBloc({
    required GetSubscriptionPlans getSubscriptionPlans,
    required PurchaseSubscription purchaseSubscription,
  })  : _getSubscriptionPlans = getSubscriptionPlans,
        _purchaseSubscription = purchaseSubscription,
        super(const PaywallState()) {
    on<PaywallPlansLoadRequested>(_onPlansLoadRequested);
    on<PaywallPlanSelected>(_onPlanSelected);
    on<PaywallPurchaseRequested>(_onPurchaseRequested);
  }

  final GetSubscriptionPlans _getSubscriptionPlans;
  final PurchaseSubscription _purchaseSubscription;

  void _onPlansLoadRequested(
    PaywallPlansLoadRequested event,
    Emitter<PaywallState> emit,
  ) {
    emit(state.copyWith(status: PaywallStatus.loading));

    final plans = _getSubscriptionPlans();

    emit(state.copyWith(
      status: PaywallStatus.loaded,
      plans: plans,
    ));
  }

  void _onPlanSelected(
    PaywallPlanSelected event,
    Emitter<PaywallState> emit,
  ) {
    emit(state.copyWith(selectedPlan: event.planType));
  }

  Future<void> _onPurchaseRequested(
    PaywallPurchaseRequested event,
    Emitter<PaywallState> emit,
  ) async {
    emit(state.copyWith(status: PaywallStatus.purchasing));

    try {
      await _purchaseSubscription(state.selectedPlan);
      emit(state.copyWith(status: PaywallStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: PaywallStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }
}
