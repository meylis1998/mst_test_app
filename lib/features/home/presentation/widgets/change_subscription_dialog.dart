import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';

class ChangeSubscriptionDialog extends StatefulWidget {
  const ChangeSubscriptionDialog({
    required this.currentPlan,
    super.key,
  });

  final SubscriptionPlanType currentPlan;

  static Future<SubscriptionPlanType?> show(
    BuildContext context, {
    required SubscriptionPlanType currentPlan,
  }) {
    return showDialog<SubscriptionPlanType>(
      context: context,
      builder: (_) => ChangeSubscriptionDialog(currentPlan: currentPlan),
    );
  }

  @override
  State<ChangeSubscriptionDialog> createState() =>
      _ChangeSubscriptionDialogState();
}

class _ChangeSubscriptionDialogState extends State<ChangeSubscriptionDialog> {
  late SubscriptionPlanType _selectedPlan;

  @override
  void initState() {
    super.initState();
    _selectedPlan = widget.currentPlan;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AlertDialog(
      title: const Text('Change Subscription'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Select your subscription plan:',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 16),
          _buildPlanOption(
            planType: SubscriptionPlanType.monthly,
            title: 'Monthly',
            subtitle: r'$9.99/month',
          ),
          const SizedBox(height: 8),
          _buildPlanOption(
            planType: SubscriptionPlanType.yearly,
            title: 'Yearly',
            subtitle: r'$59.99/year (Save 50%)',
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => context.pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: _selectedPlan == widget.currentPlan
              ? null
              : () => context.pop(_selectedPlan),
          child: const Text('Change'),
        ),
      ],
    );
  }

  Widget _buildPlanOption({
    required SubscriptionPlanType planType,
    required String title,
    required String subtitle,
  }) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isSelected = _selectedPlan == planType;

    return InkWell(
      onTap: () => setState(() => _selectedPlan = planType),
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.primary
              : colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? Colors.white : colorScheme.outline,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : null,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isSelected ? Colors.white : colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
