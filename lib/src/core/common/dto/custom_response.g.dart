// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'custom_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CustomResponse<T> _$CustomResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    CustomResponse<T>(
      statusCode: (json['status_code'] as num?)?.toInt() ?? 0,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      message: json['message'] as String? ?? "",
    );

Map<String, dynamic> _$CustomResponseToJson<T>(
  CustomResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status_code': instance.statusCode,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'message': instance.message,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
