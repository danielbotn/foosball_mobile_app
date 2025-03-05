import 'package:json_annotation/json_annotation.dart';

part 'sensor_data.g.dart';

@JsonSerializable()
class SensorData {
  final String sensor;
  final String? state;
  final int? distance;
  final String timestamp;

  SensorData({
    required this.sensor,
    this.state,
    this.distance,
    required this.timestamp,
  });

  factory SensorData.fromJson(Map<String, dynamic> json) =>
      _$SensorDataFromJson(json);

  Map<String, dynamic> toJson() => _$SensorDataToJson(this);
}
