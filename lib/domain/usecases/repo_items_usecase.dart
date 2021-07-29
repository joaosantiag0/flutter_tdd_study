import 'package:equatable/equatable.dart';

import '/domain/entities/entities.dart';

abstract class RepoItemsUsecase {
  Future<List<RepoItemEntity>> getListRepoItems();
}

class RepoItemsParams extends Equatable {
  String? id;

  RepoItemsParams({this.id});

  @override
  List<Object?> get props => [this.id];
}
