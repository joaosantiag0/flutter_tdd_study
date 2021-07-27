import 'package:equatable/equatable.dart';

import '/domain/entities/entities.dart';

abstract class MenuItemsUsecase {
  Future<List<MenuItemEntity>> getListMenuItems();
}

class MenuItemsParams extends Equatable {
  String? id;

  MenuItemsParams({this.id});

  @override
  List<Object?> get props => [this.id];
}
