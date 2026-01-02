part of 'onboarding_bloc.dart';

enum OnboardingStatus { initial, inProgress, completed }

final class OnboardingState extends Equatable {
  const OnboardingState({
    this.status = OnboardingStatus.initial,
    this.currentPage = 0,
    this.totalPages = 2,
  });

  final OnboardingStatus status;
  final int currentPage;
  final int totalPages;

  bool get isLastPage => currentPage == totalPages - 1;

  bool get isFirstPage => currentPage == 0;

  OnboardingState copyWith({
    OnboardingStatus? status,
    int? currentPage,
    int? totalPages,
  }) {
    return OnboardingState(
      status: status ?? this.status,
      currentPage: currentPage ?? this.currentPage,
      totalPages: totalPages ?? this.totalPages,
    );
  }

  @override
  List<Object?> get props => [status, currentPage, totalPages];
}
