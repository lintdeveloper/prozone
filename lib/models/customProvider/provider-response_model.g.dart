// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider-response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomProviderResponse _$CustomProviderResponseFromJson(
    Map<String, dynamic> json) {
  return CustomProviderResponse(
    id: json['id'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
    address: json['address'] as String,
    activeStatus: json['activeStatus'] as String,
    providerType: json['providerType'] == null
        ? null
        : ProviderType.fromJson(json['providerType'] as Map<String, dynamic>),
    state: json['state'] == null
        ? null
        : CustomState.fromJson(json['state'] as Map<String, dynamic>),
    images: (json['images'] as List)
        ?.map((e) =>
            e == null ? null : Images.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
  );
}

Map<String, dynamic> _$CustomProviderResponseToJson(
        CustomProviderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'address': instance.address,
      'activeStatus': instance.activeStatus,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'state': instance.state,
      'providerType': instance.providerType,
      'images': instance.images,
    };
