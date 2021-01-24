// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider-type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderType _$ProviderTypeFromJson(Map<String, dynamic> json) {
  return ProviderType(
    id: json['id'] as int,
    name: json['name'] as String,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$ProviderTypeToJson(ProviderType instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
