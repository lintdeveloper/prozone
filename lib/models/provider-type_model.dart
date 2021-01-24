import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'provider-type_model.g.dart';

@immutable
@JsonSerializable()
class ProviderType extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  ProviderType({this.id, this.name, this.createdAt, this.updatedAt});

  factory ProviderType.fromJson(Map<String, dynamic> json) =>
      _$ProviderTypeFromJson(json);

  Map<String, dynamic> toJson() => _$ProviderTypeToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    createdAt,
    updatedAt
  ];
}
