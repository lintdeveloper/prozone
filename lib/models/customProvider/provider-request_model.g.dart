// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider-request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomProviderRequest _$CustomProviderRequestFromJson(
    Map<String, dynamic> json) {
  return CustomProviderRequest(
    name: json['name'] as String,
    description: json['description'] as String,
    rating: json['rating'] as int,
    address: json['address'] as String,
    activeStatus: json['activeStatus'] as String,
    providerType: json['provider_type'] as String,
    state: json['state'] as String,
  );
}

Map<String, dynamic> _$CustomProviderRequestToJson(
        CustomProviderRequest instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'rating': instance.rating,
      'address': instance.address,
      'active_status': instance.activeStatus,
      'state': instance.state,
      'provider_type': instance.providerType,
    };
