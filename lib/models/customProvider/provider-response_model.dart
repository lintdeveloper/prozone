import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prozone/models/models.dart';
import 'package:prozone/models/state_model.dart';

part 'provider-response_model.g.dart';

@immutable
@JsonSerializable()
class CustomProviderResponse extends Equatable {
  final int id;
  final String name;
  final String description;
  final int rating;
  final String address;
  final String activeStatus;
  final String createdAt;
  final String updatedAt;
  final CustomState state;
  final ProviderType providerType;
  final List<Images> images;

  CustomProviderResponse({
    this.id,
    this.name,
    this.description,
    this.rating,
    this.address,
    this.activeStatus,
    this.providerType,
    this.state,
    this.images,
    this.createdAt,
    this.updatedAt});

  factory CustomProviderResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomProviderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CustomProviderResponseToJson(this);

  @override
  List<Object> get props => [
    id,
    name,
    description,
    rating,
    address,
    activeStatus,
    state,
    createdAt,
    updatedAt
  ];
}
