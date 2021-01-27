// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file-upload-request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FileUploadRequest _$FileUploadRequestFromJson(Map<String, dynamic> json) {
  return FileUploadRequest(
    ref: json['ref'] as String,
    refId: json['refId'] as String,
    field: json['field'] as String,
    files: json['files'] as List,
  );
}

Map<String, dynamic> _$FileUploadRequestToJson(FileUploadRequest instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'refId': instance.refId,
      'field': instance.field,
      'files': instance.files,
    };
