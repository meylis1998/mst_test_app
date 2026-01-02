part of 'paywall_bloc.dart';

sealed class PaywallEvent extends Equatable {
  const PaywallEvent();

  @override
  List<Object?> get props => [];
}

final class PaywallPlansLoadRequested extends PaywallEvent {
  const PaywallPlansLoadRequested();
}

final class PaywallPlanSelected extends PaywallEvent {
  const PaywallPlanSelected(this.planType);

  final SubscriptionPlanType planType;

  @override
  List<Object?> get props => [planType];
}

final class PaywallPurchaseRequested extends PaywallEvent {
  const PaywallPurchaseRequested();
}
