// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active-status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveStatus _$ActiveStatusFromJson(Map<String, dynamic> json) {
  return ActiveStatus(
    id: json['id'] as int,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ActiveStatusToJson(ActiveStatus instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
