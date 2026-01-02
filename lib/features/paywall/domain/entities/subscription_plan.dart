import 'package:equatable/equatable.dart';

enum SubscriptionPlanType { monthly, yearly }

class SubscriptionPlan extends Equatable {
  const SubscriptionPlan({
    required this.type,
    required this.name,
    required this.price,
    required this.period,
    this.discount,
  });

  final SubscriptionPlanType type;
  final String name;
  final String price;
  final String period;
  final String? discount;

  bool get hasDiscount => discount != null;

  @override
  List<Object?> get props => [type, name, price, period, discount];
}
