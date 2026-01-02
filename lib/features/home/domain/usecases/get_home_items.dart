import 'package:mst_test_app/features/home/domain/entities/home_item.dart';
import 'package:mst_test_app/features/home/domain/repositories/home_repository.dart';

class GetHomeItems {
  GetHomeItems(this._repository);

  final HomeRepository _repository;

  Future<List<HomeItem>> call() => _repository.getItems();
}
