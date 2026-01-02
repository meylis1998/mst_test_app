part of 'home_bloc.dart';

enum HomeStatus { initial, loading, loaded, refreshing, error }

final class HomeState extends Equatable {
  const HomeState({
    this.status = HomeStatus.initial,
    this.items = const [],
    this.errorMessage,
  });

  final HomeStatus status;
  final List<HomeItem> items;
  final String? errorMessage;

  bool get isLoading => status == HomeStatus.loading;
  bool get isRefreshing => status == HomeStatus.refreshing;
  bool get isEmpty => items.isEmpty && status == HomeStatus.loaded;

  HomeState copyWith({
    HomeStatus? status,
    List<HomeItem>? items,
    String? errorMessage,
  }) {
    return HomeState(
      status: status ?? this.status,
      items: items ?? this.items,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, items, errorMessage];
}
