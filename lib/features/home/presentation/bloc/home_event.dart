part of 'home_bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

final class HomeItemsLoadRequested extends HomeEvent {
  const HomeItemsLoadRequested();
}

final class HomeItemsRefreshRequested extends HomeEvent {
  const HomeItemsRefreshRequested();
}
