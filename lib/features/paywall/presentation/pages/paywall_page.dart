import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mst_test_app/app/router/routes.dart';
import 'package:mst_test_app/core/di/injection_container.dart';
import 'package:mst_test_app/features/paywall/presentation/bloc/paywall_bloc.dart';
import 'package:mst_test_app/features/paywall/presentation/widgets/subscription_card.dart';

class PaywallPage extends StatelessWidget {
  const PaywallPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaywallBloc>()..add(const PaywallPlansLoadRequested()),
      child: const _PaywallView(),
    );
  }
}

class _PaywallView extends StatelessWidget {
  const _PaywallView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocConsumer<PaywallBloc, PaywallState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == PaywallStatus.success) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text('Welcome to Premium!'),
              backgroundColor: colorScheme.primary,
            ),
          );
          Future.delayed(const Duration(milliseconds: 500), () {
            if (context.mounted) {
              context.go(Routes.home);
            }
          });
        } else if (state.status == PaywallStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage ?? 'Purchase failed'),
              backgroundColor: colorScheme.error,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Spacer(),
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: colorScheme.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.workspace_premium,
                      size: 50,
                      color: colorScheme.primary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Unlock Premium',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your plan',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  if (state.status == PaywallStatus.loading)
                    const CircularProgressIndicator()
                  else
                    Column(
                      children: state.plans.map((plan) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: SubscriptionCard(
                            plan: plan,
                            isSelected: state.selectedPlan == plan.type,
                            onTap: () {
                              context
                                  .read<PaywallBloc>()
                                  .add(PaywallPlanSelected(plan.type));
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: FilledButton(
                      onPressed: state.status == PaywallStatus.purchasing
                          ? null
                          : () {
                              context
                                  .read<PaywallBloc>()
                                  .add(const PaywallPurchaseRequested());
                            },
                      child: state.status == PaywallStatus.purchasing
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: colorScheme.onPrimary,
                              ),
                            )
                          : const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
