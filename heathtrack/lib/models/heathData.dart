import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class HeathData {
  final double heartRate;
  final int spb;
  final int dbp;
  final double oxygen;
  final double temperature;
  final int glucose;
  final int step;
  String? id;
  String? userId;
  HeathData({
    required this.heartRate,
    required this.spb,
    required this.dbp,
    required this.oxygen,
    required this.temperature,
    required this.glucose,
    required this.step,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'heartRate': heartRate,
      'spb': spb,
      'dbp': dbp,
      'oxygen': oxygen,
      'temperature': temperature,
      'glucose': glucose,
      'step': step,
      'id': id,
      'userId': userId,
    };
  }

  factory HeathData.fromMap(Map<String, dynamic> map) {
    return HeathData(
      heartRate: map['heartRate'] as double,
      spb: map['spb'] as int,
      dbp: map['dbp'] as int,
      oxygen: map['oxygen'] as double,
      temperature: map['temperature'] as double,
      glucose: map['glucose'] as int,
      step: map['step'] as int,
      id: map['_id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory HeathData.fromJson(String source) =>
      HeathData.fromMap(json.decode(source) as Map<String, dynamic>);
}
