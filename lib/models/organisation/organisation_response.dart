import 'package:json_annotation/json_annotation.dart';

part 'organisation_response.g.dart';

@JsonSerializable()
class OrganisationResponse {
  final int id;
  final String name;
  final DateTime createdAt;
  final int organisationType;

  OrganisationResponse({required this.id, required this.name, required this.createdAt, required this.organisationType});

  factory OrganisationResponse.fromJson(Map<String, dynamic> item) => _$OrganisationResponseFromJson(item);

  Map<String, dynamic> toJson(item) => _$OrganisationResponseToJson(item);
}