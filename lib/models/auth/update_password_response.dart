import 'package:json_annotation/json_annotation.dart';

part 'update_password_response.g.dart';

@JsonSerializable()
class UpdatePasswordResponse {
  final bool emailSent;
  final bool verificationCodeCreated;
  final bool passwordUpdated;

  UpdatePasswordResponse({
    required this.emailSent,
    required this.verificationCodeCreated,
    required this.passwordUpdated,
  });

  factory UpdatePasswordResponse.fromJson(Map<String, dynamic> item) =>
      _$UpdatePasswordResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$UpdatePasswordResponseToJson(item);
}
