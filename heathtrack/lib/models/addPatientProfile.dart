import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddPatientProfile {
  final String name;
  final DateTime dateOfBirth;
  final String gender;
  final String phoneNumber;
  final String image;
  final String email;
  final double height;
  final double weight;
  final String bmi;
  String? id;
  String? userId;
  AddPatientProfile({
    required this.name,
    required this.dateOfBirth,
    required this.gender,
    required this.phoneNumber,
    required this.image,
    required this.email,
    required this.height,
    required this.weight,
    required this.bmi,
    this.id,
    this.userId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'dateOfBirth': dateOfBirth.millisecondsSinceEpoch,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'image': image,
      'email': email,
      'height': height,
      'weight': weight,
      'bmi': bmi,
      'id': id,
      'userId': userId,
    };
  }

  factory AddPatientProfile.fromMap(Map<String, dynamic> map) {
    return AddPatientProfile(
      name: map['name'] as String,
      dateOfBirth:
          DateTime.fromMillisecondsSinceEpoch(map['dateOfBirth'] as int),
      gender: map['gender'] as String,
      phoneNumber: map['phoneNumber'] as String,
      image: map['image'] as String,
      email: map['email'] as String,
      height: map['height'] as double,
      weight: map['weight'] as double,
      bmi: map['bmi'] as String,
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AddPatientProfile.fromJson(String source) =>
      AddPatientProfile.fromMap(json.decode(source) as Map<String, dynamic>);
}
