import 'package:mst_test_app/features/home/domain/entities/home_item.dart';

abstract class HomeRepository {
  Future<List<HomeItem>> getItems();

  Future<List<HomeItem>> refreshItems();
}
