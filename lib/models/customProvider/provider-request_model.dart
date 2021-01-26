import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prozone/models/state_model.dart';
import '../images_model.dart';
import '../provider-type_model.dart';

part 'provider-request_model.g.dart';

@immutable
@JsonSerializable()
class CustomProviderRequest extends Equatable {
  final String name;
  final String description;
  final int rating;
  final String address;
  final String activeStatus;
  final String state;
  final String providerType;

  CustomProviderRequest({
    this.name,
    this.description,
    this.rating,
    this.address,
    this.activeStatus,
    this.providerType,
    this.state});

  factory CustomProviderRequest.fromJson(Map<String, dynamic> json) =>
      _$CustomProviderRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CustomProviderRequestToJson(this);

  @override
  List<Object> get props => [
    name,
    description,
    rating,
    address,
    activeStatus,
    state,
  ];
}
