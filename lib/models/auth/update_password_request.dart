import 'package:json_annotation/json_annotation.dart';

part 'update_password_request.g.dart';

@JsonSerializable()
class UpdatePasswordRequest {
  final String password;
  final String confirmPassword;
  final String verificationCode;

  UpdatePasswordRequest({
    required this.password,
    required this.confirmPassword,
    required this.verificationCode,
  });

  factory UpdatePasswordRequest.fromJson(Map<String, dynamic> item) =>
      _$UpdatePasswordRequestFromJson(item);

  Map<String, dynamic> toJson(item) => _$UpdatePasswordRequestToJson(item);
}
