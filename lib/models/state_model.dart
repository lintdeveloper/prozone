import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'state_model.g.dart';

@immutable
@JsonSerializable()
class CustomState extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  CustomState({this.id, this.name, this.createdAt, this.updatedAt});

  factory CustomState.fromJson(Map<String, dynamic> json) =>
      _$CustomStateFromJson(json);

  Map<String, dynamic> toJson() => _$CustomStateToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    createdAt,
    updatedAt
  ];
}
