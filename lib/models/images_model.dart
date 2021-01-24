import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'images_model.g.dart';

@immutable
@JsonSerializable()
class Images extends Equatable {
  final int id;
  final String name;
  final String url;
  final String createdAt;
  final String updatedAt;

  Images({this.id, this.name, this.url, this.createdAt, this.updatedAt});

  factory Images.fromJson(Map<String, dynamic> json) =>
      _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    url,
    createdAt,
    updatedAt
  ];
}
