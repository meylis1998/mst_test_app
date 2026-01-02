import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mst_test_app/app/router/routes.dart';

/// Application router configuration.
class AppRouter {
  AppRouter();

  late final GoRouter router = GoRouter(
    initialLocation: Routes.initial,
    debugLogDiagnostics: true,
    routes: _routes,
    errorBuilder: _errorBuilder,
  );

  List<RouteBase> get _routes => [
        GoRoute(
          path: Routes.initial,
          name: RouteNames.initial,
          builder: (context, state) => const _PlaceholderPage(title: 'Home'),
        ),
        GoRoute(
          path: Routes.login,
          name: RouteNames.login,
          builder: (context, state) => const _PlaceholderPage(title: 'Login'),
        ),
        GoRoute(
          path: Routes.register,
          name: RouteNames.register,
          builder: (context, state) => const _PlaceholderPage(title: 'Register'),
        ),
        GoRoute(
          path: Routes.home,
          name: RouteNames.home,
          builder: (context, state) => const _PlaceholderPage(title: 'Home'),
        ),
        GoRoute(
          path: Routes.settings,
          name: RouteNames.settings,
          builder: (context, state) => const _PlaceholderPage(title: 'Settings'),
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

/// Placeholder page for routes that haven't been implemented yet.
class _PlaceholderPage extends StatelessWidget {
  const _PlaceholderPage({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.construction,
              size: 64,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 16),
            Text(
              '$title Page',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'This page is under construction',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withAlpha(153),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
