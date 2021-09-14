
import 'package:json_annotation/json_annotation.dart';

part 'jwt_model.g.dart';

@JsonSerializable()
class JwtModel {
  final String name;
  final String currentOrganisationId;
  final int nbf;
  final int exp;
  final int iat;

  JwtModel({
    required this.name,
    required this.currentOrganisationId,
    required this.nbf,
    required this.exp,
    required this.iat
    }
  );

  factory JwtModel.fromJson(Map<String, dynamic> item) => _$JwtModelFromJson(item);

  Map<String, dynamic> toJson(item) => _$JwtModelToJson(item);
}