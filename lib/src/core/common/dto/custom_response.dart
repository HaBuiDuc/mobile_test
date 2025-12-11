import 'package:json_annotation/json_annotation.dart';

part 'custom_response.g.dart';


@JsonSerializable(genericArgumentFactories: true)
class CustomResponse<T> {
  const CustomResponse({
    this.statusCode = 0,
    this.data,
    this.message = "",
  });

  factory CustomResponse.fromJson(
      Map<String, dynamic> json, T Function(Object?) fromJsonT) {
    return _$CustomResponseFromJson(json, fromJsonT);
  }

  @JsonKey(name: "status_code")
  final int statusCode;
  @JsonKey(name: "data")
  final T? data;
  @JsonKey(name: "message")
  final String message;

  bool get isSuccess => statusCode == 200 || statusCode == 201;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      _$CustomResponseToJson(this, toJsonT);

  @override
  String toString() =>
      'ApiResult{status: $statusCode, data: $data, message: $message}';
}
