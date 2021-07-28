import 'package:dev_tools/data/models/models.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/entities/menu_item_entity.dart';
import '../../domain/usecases/usecases.dart';

import '/data/http/http.dart';

class MenuItemsUsecaseImplementation implements MenuItemsUsecase {
  final HttpClient httpClient;
  final String url;

  MenuItemsUsecaseImplementation({required this.httpClient, required this.url});

  @override
  Future<List<MenuItemEntity>> getListMenuItems() async {
    try {
      final httpClientResponse =
          await httpClient.request(url: this.url, method: 'GET');
      return GitContentModel.fromJsonArray(httpClientResponse)
          .map((e) => e.toEntity())
          .toList();
    } on HttpError {
      throw DomainError.unexpectedError;
    }
  }
}
