import 'package:json_annotation/json_annotation.dart';

part 'user_response.g.dart';

@JsonSerializable()
class UserResponse {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final DateTime createdAt;
  final int? currentOrganisationId;
  final String photoUrl;
  final bool? isAdmin;
  final bool isDeleted;

  UserResponse({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.createdAt,
    required this.currentOrganisationId,
    required this.photoUrl,
    this.isAdmin,
    required this.isDeleted,
  });

  /// Factory method to create an instance of UserResponse from JSON
  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  /// Method to convert an instance of UserResponse to JSON
  /// Handles both the case with or without the `item` parameter
  Map<String, dynamic> toJson([dynamic item]) {
    if (item != null) {
      return _$UserResponseToJson(item);
    } else {
      return _$UserResponseToJson(this);
    }
  }
}
