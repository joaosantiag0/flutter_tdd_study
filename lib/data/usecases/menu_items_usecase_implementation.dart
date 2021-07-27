import '../../domain/entities/menu_item_entity.dart';
import '../../domain/usecases/usecases.dart';

import '/data/http/http.dart';

class MenuItemsUsecaseImplementation implements MenuItemsUsecase {
  final HttpClient httpClient;
  final String url;

  MenuItemsUsecaseImplementation({required this.httpClient, required this.url});

  @override
  Future<List<MenuItemEntity>> getListMenuItems() async {
    await httpClient.request(url: this.url, method: 'GET');

    return [];
  }
}
