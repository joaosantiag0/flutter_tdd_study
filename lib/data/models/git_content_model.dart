import 'package:equatable/equatable.dart';
import 'package:flutter/physics.dart';

import '../../domain/entities/entities.dart';

class GitContentModel extends Equatable {
  final String name;
  final String path;
  final String downloadUrl;
  final String type;

  GitContentModel(
      {required this.name,
      required this.path,
      required this.downloadUrl,
      required this.type});

  @override
  List<Object?> get props =>
      [this.name, this.path, this.downloadUrl, this.type];

  static List<GitContentModel> fromJsonArray(List<dynamic> json) {
    return json
        .map((e) => GitContentModel(
            name: e["name"],
            path: e["path"],
            downloadUrl: e["download_url"],
            type: e["type"]))
        .toList();
  }

  MenuItemEntity toEntity() => MenuItemEntity(id: this.path, name: this.name);
}
