import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
part 'active-status_model.g.dart';

@immutable
@JsonSerializable()
class ActiveStatus extends Equatable {
  final int id;
  final String name;
  final String createdAt;
  final String updatedAt;

  ActiveStatus({this.id, this.name, this.createdAt, this.updatedAt});

  factory ActiveStatus.fromJson(Map<String, dynamic> json) =>
      _$ActiveStatusFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveStatusToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    createdAt,
    updatedAt
  ];
}
