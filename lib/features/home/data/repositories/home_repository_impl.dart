import 'package:mst_test_app/features/home/data/datasources/home_local_datasource.dart';
import 'package:mst_test_app/features/home/domain/entities/home_item.dart';
import 'package:mst_test_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._localDatasource);

  final HomeLocalDatasource _localDatasource;

  @override
  Future<List<HomeItem>> getItems() {
    return _localDatasource.getItems();
  }

  @override
  Future<List<HomeItem>> refreshItems() {
    return _localDatasource.refreshItems();
  }
}
