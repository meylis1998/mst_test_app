import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mst_test_app/app/router/routes.dart';
import 'package:mst_test_app/core/di/injection_container.dart';
import 'package:mst_test_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_empty_state.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_error_state.dart';
import 'package:mst_test_app/features/home/presentation/widgets/home_item_card.dart';

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

class _HomeView extends StatelessWidget {
  const _HomeView();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push(Routes.settings),
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
