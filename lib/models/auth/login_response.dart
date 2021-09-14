import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String token;

  LoginResponse({required this.id, required this.email, required this.firstName, required this.lastName, required this.token});

  factory LoginResponse.fromJson(Map<String, dynamic> item) => _$LoginResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$LoginResponseToJson(item);
}