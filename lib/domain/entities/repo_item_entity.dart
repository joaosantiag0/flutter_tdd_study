import 'package:equatable/equatable.dart';

class MenuItemEntity extends Equatable {
  final String name;
  final String? icon;
  final String id;

  MenuItemEntity({
    required this.id,
    required this.name,
    this.icon,
  });

  @override
  List<Object?> get props => [name, icon, id];
}
