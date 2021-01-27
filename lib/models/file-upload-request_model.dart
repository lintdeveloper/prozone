import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'file-upload-request_model.g.dart';

@immutable
@JsonSerializable()
class FileUploadRequest extends Equatable {
  final String ref;
  final String refId;
  final String field;
  final List files;

  FileUploadRequest({this.ref, this.refId, this.field, this.files});

  factory FileUploadRequest.fromJson(Map<String, dynamic> json) =>
      _$FileUploadRequestFromJson(json);

  Map<String, dynamic> toJson() => _$FileUploadRequestToJson(this);

  @override
  List<Object> get props => [
    ref,
    refId,
    field,
    files
  ];
}
