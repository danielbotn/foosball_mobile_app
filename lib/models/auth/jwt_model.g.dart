// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'jwt_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JwtModel _$JwtModelFromJson(Map<String, dynamic> json) => JwtModel(
      name: json['name'] as String,
      currentOrganisationId: json['currentOrganisationId'] as String,
      nbf: (json['nbf'] as num).toInt(),
      exp: (json['exp'] as num).toInt(),
      iat: (json['iat'] as num).toInt(),
    );

Map<String, dynamic> _$JwtModelToJson(JwtModel instance) => <String, dynamic>{
      'name': instance.name,
      'currentOrganisationId': instance.currentOrganisationId,
      'nbf': instance.nbf,
      'exp': instance.exp,
      'iat': instance.iat,
    };
