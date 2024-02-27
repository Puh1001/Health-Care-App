import 'package:flutter/cupertino.dart';

class Patient with ChangeNotifier{
  String name;
  String id;
  DateTime? dateOfBirth;
  String? sex = 'No information';

  String? address;
  String? phoneNumber;
  String? email;

  double? height =0;
  double? weight =0;
  int? heartRate =0;
  int? bloodPressure =0;
  double? bodyTemperature =0;
  double? oxygenSaturation =0;
  int? bloodGlucoseLevel =0;

  String diagnose;
  Patient({
    required this.name,
    this.id = '',
    this.dateOfBirth,
    this.sex,
    this.diagnose = 'No information',
    this.address,
    this.phoneNumber,
    this.email,
    this.height,
    this.weight,
    this.heartRate,
    this.bloodPressure,
    this.bodyTemperature,
    this.oxygenSaturation,
    this.bloodGlucoseLevel,
  });
  set nname(String newname){
    name = newname;
    notifyListeners();
  }
  void updatePatientInfo({
    String? name,
    DateTime? dateOfBirth,
    String? sex,
    String? address,
    String? phoneNumber,
    String? email,
    double? height,
    double? weight,
    int? heartRate,
    int? bloodPressure,
    double? bodyTemperature,
    double? oxygenSaturation,
    int? bloodGlucoseLevel,
  }) {
    this.name = name ?? this.name;
    this.dateOfBirth = dateOfBirth ?? this.dateOfBirth;
    this.sex = sex ?? this.sex;
    this.address = address ?? this.address;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.email = email ?? this.email;
    this.height = height ?? this.height;
    this.weight = weight ?? this.weight;
    this.heartRate = heartRate ?? this.heartRate;
    this.bloodPressure = bloodPressure ?? this.bloodPressure;
    this.bodyTemperature = bodyTemperature ?? this.bodyTemperature;
    this.oxygenSaturation = oxygenSaturation ?? this.oxygenSaturation;
    this.bloodGlucoseLevel = bloodGlucoseLevel ?? this.bloodGlucoseLevel;

    notifyListeners();
  }

  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  void updateDateOfBirth(DateTime newDateOfBirth) {
    dateOfBirth = newDateOfBirth;
    notifyListeners();
  }

  void updateSex(String newSex) {
    sex = newSex;
    notifyListeners();
  }

  void updateAddress(String newAddress) {
    address = newAddress;
    notifyListeners();
  }

  void updatePhoneNumber(String newPhoneNumber) {
    phoneNumber = newPhoneNumber;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    email = newEmail;
    notifyListeners();
  }

  void updateHeight(double newHeight) {
    height = newHeight;
    notifyListeners();
  }

  void updateWeight(double newWeight) {
    weight = newWeight;
    notifyListeners();
  }

  void updateHeartRate(int newHeartRate) {
    heartRate = newHeartRate;
    notifyListeners();
  }

  void updateBloodPressure(int newBloodPressure) {
    bloodPressure = newBloodPressure;
    notifyListeners();
  }

  void updateBodyTemperature(double newBodyTemperature) {
    bodyTemperature = newBodyTemperature;
    notifyListeners();
  }

  void updateOxygenSaturation(double newOxygenSaturation) {
    oxygenSaturation = newOxygenSaturation;
    notifyListeners();
  }

  void updateBloodGlucoseLevel(int newBloodGlucoseLevel) {
    bloodGlucoseLevel = newBloodGlucoseLevel;
    notifyListeners();
  }
}