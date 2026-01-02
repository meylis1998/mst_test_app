import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mst_test_app/app/router/app_router.dart';
import 'package:mst_test_app/app/theme/app_theme.dart';
import 'package:mst_test_app/core/constants/app_constants.dart';
import 'package:mst_test_app/core/di/injection_container.dart';
import 'package:mst_test_app/shared/presentation/blocs/theme/theme_bloc.dart';

/// Root application widget.
class App extends StatelessWidget {
  App({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(
          create: (_) => sl<ThemeBloc>()..add(const ThemeLoadRequested()),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: AppConstants.appName,
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            routerConfig: _appRouter.router,
          );
        },
      ),
    );
  }
}
