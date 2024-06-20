// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordResponse _$UpdatePasswordResponseFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordResponse(
      emailSent: json['emailSent'] as bool,
      verificationCodeCreated: json['verificationCodeCreated'] as bool,
      passwordUpdated: json['passwordUpdated'] as bool,
    );

Map<String, dynamic> _$UpdatePasswordResponseToJson(
        UpdatePasswordResponse instance) =>
    <String, dynamic>{
      'emailSent': instance.emailSent,
      'verificationCodeCreated': instance.verificationCodeCreated,
      'passwordUpdated': instance.passwordUpdated,
    };
