import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:mst_test_app/app/router/routes.dart';
import 'package:mst_test_app/features/home/presentation/pages/home_page.dart';
import 'package:mst_test_app/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mst_test_app/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:mst_test_app/features/paywall/domain/repositories/subscription_repository.dart';
import 'package:mst_test_app/features/paywall/presentation/pages/paywall_page.dart';

class AppRouter {
  AppRouter({
    required OnboardingRepository onboardingRepository,
    required SubscriptionRepository subscriptionRepository,
  })  : _onboardingRepository = onboardingRepository,
        _subscriptionRepository = subscriptionRepository;

  final OnboardingRepository _onboardingRepository;
  final SubscriptionRepository _subscriptionRepository;

  late final GoRouter router = GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: _routes,
    redirect: _redirect,
    errorBuilder: _errorBuilder,
  );

  Future<String?> _redirect(BuildContext context, GoRouterState state) async {
    final isOnboardingCompleted =
        await _onboardingRepository.isOnboardingCompleted();
    final isSubscribed = await _subscriptionRepository.isSubscribed();
    final currentLocation = state.matchedLocation;

    if (currentLocation == Routes.initial) {
      if (!isOnboardingCompleted) {
        return Routes.onboarding;
      }
      if (!isSubscribed) {
        return Routes.paywall;
      }
      return Routes.home;
    }

    if (currentLocation == Routes.onboarding && isOnboardingCompleted) {
      return isSubscribed ? Routes.home : Routes.paywall;
    }

    if (currentLocation == Routes.paywall && isSubscribed) {
      return Routes.home;
    }

    return null;
  }

  List<RouteBase> get _routes => [
        GoRoute(
          path: Routes.initial,
          name: RouteNames.initial,
          builder: (context, state) => const SizedBox.shrink(),
        ),
        GoRoute(
          path: Routes.onboarding,
          name: RouteNames.onboarding,
          builder: (context, state) => const OnboardingPage(),
        ),
        GoRoute(
          path: Routes.paywall,
          name: RouteNames.paywall,
          builder: (context, state) => const PaywallPage(),
        ),
        GoRoute(
          path: Routes.home,
          name: RouteNames.home,
          builder: (context, state) => const HomePage(),
        ),
      ];

  Widget _errorBuilder(BuildContext context, GoRouterState state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Page not found',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              state.uri.toString(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(Routes.initial),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}
