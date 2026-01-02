import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:mst_test_app/app/router/routes.dart';
import 'package:mst_test_app/core/di/injection_container.dart';
import 'package:mst_test_app/features/onboarding/presentation/bloc/onboarding_bloc.dart';
import 'package:mst_test_app/features/onboarding/presentation/widgets/onboarding_content.dart';
import 'package:mst_test_app/features/onboarding/presentation/widgets/page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  late final PageController _pageController;

  static const _pages = [
    _PageData(
      icon: Icons.rocket_launch_outlined,
      title: 'Welcome',
      description:
          'Discover powerful features that help you achieve more every day.',
    ),
    _PageData(
      icon: Icons.auto_awesome_outlined,
      title: 'Unlock Premium',
      description: 'Get access to advanced tools and personalized insights.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingBloc>(),
      child: BlocConsumer<OnboardingBloc, OnboardingState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == OnboardingStatus.completed) {
            context.go(Routes.paywall);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _pages.length,
                      onPageChanged: (index) {
                        context
                            .read<OnboardingBloc>()
                            .add(OnboardingPageChanged(index));
                      },
                      itemBuilder: (context, index) {
                        final page = _pages[index];
                        return OnboardingContent(
                          icon: page.icon,
                          title: page.title,
                          description: page.description,
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      children: [
                        PageIndicator(
                          currentPage: state.currentPage,
                          pageCount: state.totalPages,
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: FilledButton(
                            onPressed: () => _onButtonPressed(context, state),
                            child: Text(
                              state.isLastPage ? 'Continue' : 'Next',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onButtonPressed(BuildContext context, OnboardingState state) {
    if (state.isLastPage) {
      context.read<OnboardingBloc>().add(const OnboardingCompleted());
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }
}

class _PageData {
  const _PageData({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;
}
