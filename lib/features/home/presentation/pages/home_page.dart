import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mst_test_app/core/di/injection_container.dart';
import 'package:mst_test_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:mst_test_app/features/home/presentation/widgets/change_subscription_dialog.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_empty_state.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_error_state.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_item_card.dart';
import 'package:mst_test_app/features/paywall/domain/entities/subscription_plan.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>()..add(const HomeItemsLoadRequested()),
      child: const _HomeView(),
    );
  }
}

class _HomeView extends StatefulWidget {
  const _HomeView();

  @override
  State<_HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<_HomeView> {
  final _subscriptionRepository = sl<SubscriptionRepository>();
  SubscriptionPlanType? _currentPlan;

  @override
  void initState() {
    super.initState();
    _loadSubscription();
  }

  Future<void> _loadSubscription() async {
    final plan = await _subscriptionRepository.getSubscriptionPlanType();
    if (mounted) {
      setState(() => _currentPlan = plan);
    }
  }

  Future<void> _onSubscriptionBadgeTap() async {
    if (_currentPlan == null) return;

    final newPlan = await ChangeSubscriptionDialog.show(
      context,
      currentPlan: _currentPlan!,
    );

    if (newPlan != null && newPlan != _currentPlan && mounted) {
      await _subscriptionRepository.purchaseSubscription(newPlan);
      setState(() => _currentPlan = newPlan);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Switched to ${newPlan == SubscriptionPlanType.yearly ? 'Yearly' : 'Monthly'} plan',
            ),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        actions: [
          if (_currentPlan != null)
            GestureDetector(
              onTap: _onSubscriptionBadgeTap,
              child: _SubscriptionBadge(planType: _currentPlan!),
            ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == HomeStatus.error) {
            return HomeErrorState(
              message: state.errorMessage,
              onRetry: () {
                context.read<HomeBloc>().add(const HomeItemsLoadRequested());
              },
            );
          }

          if (state.isEmpty) {
            return HomeEmptyState(
              onRetry: () {
                context.read<HomeBloc>().add(const HomeItemsLoadRequested());
              },
            );
          }

          return RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(const HomeItemsRefreshRequested());
              await context.read<HomeBloc>().stream.firstWhere(
                    (s) => s.status != HomeStatus.refreshing,
                  );
            },
            color: colorScheme.primary,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return HomeItemCard(
                  item: item,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Tapped: ${item.title}'),
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 1),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _SubscriptionBadge extends StatelessWidget {
  const _SubscriptionBadge({required this.planType});

  final SubscriptionPlanType planType;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isYearly = planType == SubscriptionPlanType.yearly;

    return Container(
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isYearly
            ? colorScheme.primaryContainer
            : colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.workspace_premium,
            size: 16,
            color: isYearly
                ? colorScheme.onPrimaryContainer
                : colorScheme.onTertiaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            isYearly ? 'Yearly' : 'Monthly',
            style: theme.textTheme.labelMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: isYearly
                  ? colorScheme.onPrimaryContainer
                  : colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
