import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mst_test_app/features/home/domain/entities/home_item.dart';
import 'package:mst_test_app/features/home/domain/usecases/get_home_items.dart';
import 'package:mst_test_app/features/home/domain/usecases/refresh_home_items.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({
    required GetHomeItems getHomeItems,
    required RefreshHomeItems refreshHomeItems,
  })  : _getHomeItems = getHomeItems,
        _refreshHomeItems = refreshHomeItems,
        super(const HomeState()) {
    on<HomeItemsLoadRequested>(_onItemsLoadRequested);
    on<HomeItemsRefreshRequested>(_onItemsRefreshRequested);
  }

  final GetHomeItems _getHomeItems;
  final RefreshHomeItems _refreshHomeItems;

  Future<void> _onItemsLoadRequested(
    HomeItemsLoadRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.loading));

    try {
      final items = await _getHomeItems();
      emit(state.copyWith(
        status: HomeStatus.loaded,
        items: items,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onItemsRefreshRequested(
    HomeItemsRefreshRequested event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(status: HomeStatus.refreshing));

    try {
      final items = await _refreshHomeItems();
      emit(state.copyWith(
        status: HomeStatus.loaded,
        items: items,
      ));
    } on Exception catch (e) {
      emit(state.copyWith(
        status: HomeStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
