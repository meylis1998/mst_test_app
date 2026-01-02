part of 'paywall_bloc.dart';

enum PaywallStatus { initial, loading, loaded, purchasing, success, failure }

final class PaywallState extends Equatable {
  const PaywallState({
    this.status = PaywallStatus.initial,
    this.selectedPlan = SubscriptionPlanType.yearly,
    this.plans = const [],
    this.errorMessage,
  });

  final PaywallStatus status;
  final SubscriptionPlanType selectedPlan;
  final List<SubscriptionPlan> plans;
  final String? errorMessage;

  SubscriptionPlan? get selectedPlanDetails {
    for (final plan in plans) {
      if (plan.type == selectedPlan) {
        return plan;
      }
    }
    return null;
  }

  PaywallState copyWith({
    PaywallStatus? status,
    SubscriptionPlanType? selectedPlan,
    List<SubscriptionPlan>? plans,
    String? errorMessage,
  }) {
    return PaywallState(
      status: status ?? this.status,
      selectedPlan: selectedPlan ?? this.selectedPlan,
      plans: plans ?? this.plans,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, selectedPlan, plans, errorMessage];
}
