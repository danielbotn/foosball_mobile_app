import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable()
class RegisterResponse {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final int? currentOrganisationId;
  final String? photoUrl;

  RegisterResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.currentOrganisationId,
    required this.photoUrl});

  factory RegisterResponse.fromJson(Map<String, dynamic> item) => _$RegisterResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$RegisterResponseToJson(item);
}