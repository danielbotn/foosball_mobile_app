import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final int currentOrganisationId;

  UserResponse({required this.id, required this.email, required this.firstName, required this.lastName, required this.createdAt, required this.currentOrganisationId});

  factory UserResponse.fromJson(Map<String, dynamic> item) => _$UserResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$UserResponseToJson(item);
}