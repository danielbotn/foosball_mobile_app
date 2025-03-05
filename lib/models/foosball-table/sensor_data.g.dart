// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SensorData _$SensorDataFromJson(Map<String, dynamic> json) => SensorData(
      sensor: json['sensor'] as String,
      state: json['state'] as String?,
      distance: (json['distance'] as num?)?.toInt(),
      timestamp: json['timestamp'] as String,
    );

Map<String, dynamic> _$SensorDataToJson(SensorData instance) =>
    <String, dynamic>{
      'sensor': instance.sensor,
      'state': instance.state,
      'distance': instance.distance,
      'timestamp': instance.timestamp,
    };
