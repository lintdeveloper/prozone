import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:prozone/models/state_model.dart';
import 'images_model.dart';
import 'provider-type_model.dart';

part 'provider_model.g.dart';

@immutable
@JsonSerializable()
class CustomProvider extends Equatable {
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

  CustomProvider({
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

  factory CustomProvider.fromJson(Map<String, dynamic> json) =>
      _$CustomProviderFromJson(json);

  Map<String, dynamic> toJson() => _$CustomProviderToJson(this);

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
