import 'package:equatable/equatable.dart';

class MenuItemEntity extends Equatable {
  String name;
  String? icon;
  String id;

  MenuItemEntity({
    required this.id,
    required this.name,
    this.icon,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, icon, id];
}
