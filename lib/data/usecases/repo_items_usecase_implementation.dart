import 'package:dev_tools/data/models/models.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/entities/repo_item_entity.dart';
import '../../domain/usecases/usecases.dart';

import '/data/http/http.dart';

class RepoItemsUsecaseImplementation implements RepoItemsUsecase {
  final HttpClient httpClient;
  final String url;

  RepoItemsUsecaseImplementation({required this.httpClient, required this.url});

  @override
  Future<List<RepoItemEntity>> getListRepoItems() async {
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
