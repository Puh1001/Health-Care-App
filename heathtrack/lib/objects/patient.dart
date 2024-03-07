
import 'package:heathtrack/k_services/diagnoseEngine.dart';
import 'package:heathtrack/models/heathData.dart';

import '../models/user.dart';

class Patient extends User {
  final String phoneNumber;
  final DateTime? dateOfBirth;
  final String? gender;
  final double? height;
  final double? weight;
  List<HeathData> healthDataList = [];

  int? heartRate =0;
  int? systolic = 0;
  int? diastolic = 0;
  double? bodyTemperature =0;
  double? oxygenSaturation =0;
  double? bloodGlucoseLevel =0;
  String? diagnose = '';

  //status: 0 :tốt, 1: cảnh báo, 2: nguy hiểm
  var heartRateStatus = 0;
  var bloodPressureStatus = 0;
  var bodyTemperatureStatus = 0;
  var oxygenSaturationStatus = 0;
  var bloodGlucoseLevelStatus = 0;
  var overviewStatus = 0;
  Patient({
    required String id,
    required String name,
    required String email,
    required String password,
    required String familyCode,
    required String address,
    required String type,
    required String token,
    this.phoneNumber = '',
    this.dateOfBirth,
    this.gender,
    this.height,
    this.weight,
    this.heartRate,
    this.systolic,
    this.diastolic,
    this.bodyTemperature,
    this.oxygenSaturation,
    this.bloodGlucoseLevel,
    this.diagnose,
    this.healthDataList = const []
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
    familyCode: familyCode,
    address: address,
    type: type,
    token: token,
  );

  updateStatus(){
    String diagnoseBloodPressureIssue =(systolic!=null && diastolic !=null)? DiagnosisEngine.diagnoseBloodPressureIssue(systolic!,diastolic!):'';
    switch (diagnoseBloodPressureIssue) {
      case "Optimal blood pressure":
        heartRateStatus = 0;break;
      case "Normal blood pressure":
        heartRateStatus = 0;break;
      case "Prehypertension":
        heartRateStatus = 1;break;
      case "Hypertension stage 1":
        heartRateStatus = 1;break;
      case "Hypertension stage 2":
        heartRateStatus = 2;break;
      case "Hypertension stage 3":
        heartRateStatus = 2;break;
      case "Isolated systolic hypertension":
        heartRateStatus = 1;break;
      default:
        heartRateStatus = -1;break;}

    String diagnoseHeartRateIssue =heartRate!=null? DiagnosisEngine.diagnoseHeartRateIssue(heartRate!):'';
    switch (diagnoseHeartRateIssue) {
      case 'Low heart rate':
        heartRateStatus = 1; break;
      case 'Normal heart rate':
        heartRateStatus = 0; break;
      case 'High heart rate':
        heartRateStatus = 1; break;
      case 'Dangerous':
        heartRateStatus = 2; break;
      default:
        heartRateStatus = -1; break;
    }
    String diagnoseBloodGlucoseLevelIssue =bloodGlucoseLevel!=null? DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(bloodGlucoseLevel!):'';
    switch (diagnoseBloodGlucoseLevelIssue) {
      case 'Low blood glucose level':
        bloodGlucoseLevel = 1;
        break;
      case 'Normal blood glucose level':
        bloodGlucoseLevel = 0;
        break;
      case 'High blood glucose level':
        bloodGlucoseLevel = 1;
        break;
      default:
        bloodGlucoseLevel = -1;
        break;
    }
    String diagnoseTemperatureIssue =bodyTemperature!=null? DiagnosisEngine.diagnoseTemperatureIssue(bodyTemperature!):'';
    switch (diagnoseTemperatureIssue) {
      case 'Low body temperature':
        bodyTemperatureStatus = 1;break;
      case 'Normal body temperature':
        bodyTemperatureStatus = 0;break;
      case 'High body temperature':
        bodyTemperatureStatus = 1;break;
      default:
        bodyTemperatureStatus = -1;break;
    }
    String diagnoseOxygenSaturationIssue =bodyTemperature!=null? DiagnosisEngine.diagnoseOxygenSaturationIssue(bodyTemperature!):'';
    switch (diagnoseOxygenSaturationIssue) {
      case 'Low oxygen saturation':
        oxygenSaturationStatus = 1;break;
      case 'Normal oxygen saturation':
        oxygenSaturationStatus = 0;break;
      case 'High oxygen saturation':
        oxygenSaturationStatus = 1;break;
      default:
        oxygenSaturationStatus = -1;break;
    }


     overviewStatus = 0;
  }
}
// class Patient with ChangeNotifier{
//   String name;
//   String id;
//   DateTime? dateOfBirth;
//   String? sex = 'No information';
//
//   String? address;
//   String? phoneNumber;
//   String? email;
//
//   double? height =0;
//   double? weight =0;
//   int? heartRate =0;
//   int? bloodPressure =0;
//   double? bodyTemperature =0;
//   double? oxygenSaturation =0;
//   int? bloodGlucoseLevel =0;
//
//   String diagnose;
//   Patient({
//     required this.name,
//     this.id = '',
//     this.dateOfBirth,
//     this.sex,
//     this.diagnose = 'No information',
//     this.address,
//     this.phoneNumber,
//     this.email,
//     this.height,
//     this.weight,
//     this.heartRate,
//     this.bloodPressure,
//     this.bodyTemperature,
//     this.oxygenSaturation,
//     this.bloodGlucoseLevel,
//   });
//   set nname(String newname){
//     name = newname;
//     notifyListeners();
//   }
//   void updatePatientInfo({
//     String? name,
//     DateTime? dateOfBirth,
//     String? sex,
//     String? address,
//     String? phoneNumber,
//     String? email,
//     double? height,
//     double? weight,
//     int? heartRate,
//     int? bloodPressure,
//     double? bodyTemperature,
//     double? oxygenSaturation,
//     int? bloodGlucoseLevel,
//   }) {
//     this.name = name ?? this.name;
//     this.dateOfBirth = dateOfBirth ?? this.dateOfBirth;
//     this.sex = sex ?? this.sex;
//     this.address = address ?? this.address;
//     this.phoneNumber = phoneNumber ?? this.phoneNumber;
//     this.email = email ?? this.email;
//     this.height = height ?? this.height;
//     this.weight = weight ?? this.weight;
//     this.heartRate = heartRate ?? this.heartRate;
//     this.bloodPressure = bloodPressure ?? this.bloodPressure;
//     this.bodyTemperature = bodyTemperature ?? this.bodyTemperature;
//     this.oxygenSaturation = oxygenSaturation ?? this.oxygenSaturation;
//     this.bloodGlucoseLevel = bloodGlucoseLevel ?? this.bloodGlucoseLevel;
//
//     notifyListeners();
//   }
//
//   void updateName(String newName) {
//     name = newName;
//     notifyListeners();
//   }
//
//   void updateDateOfBirth(DateTime newDateOfBirth) {
//     dateOfBirth = newDateOfBirth;
//     notifyListeners();
//   }
//
//   // void updateSex(String newSex) {
//   //   sex = newSex;
//   //   notifyListeners();
//   // }
//
//   void updateAddress(String newAddress) {
//     address = newAddress;
//     notifyListeners();
//   }
//
//   void updatePhoneNumber(String newPhoneNumber) {
//     phoneNumber = newPhoneNumber;
//     notifyListeners();
//   }
//
//   void updateEmail(String newEmail) {
//     email = newEmail;
//     notifyListeners();
//   }
//
//   void updateHeight(double newHeight) {
//     height = newHeight;
//     notifyListeners();
//   }
//
//   void updateWeight(double newWeight) {
//     weight = newWeight;
//     notifyListeners();
//   }
//
//   void updateHeartRate(int newHeartRate) {
//     heartRate = newHeartRate;
//     notifyListeners();
//   }
//
//   void updateBloodPressure(int newBloodPressure) {
//     bloodPressure = newBloodPressure;
//     notifyListeners();
//   }
//
//   void updateBodyTemperature(double newBodyTemperature) {
//     bodyTemperature = newBodyTemperature;
//     notifyListeners();
//   }
//
//   void updateOxygenSaturation(double newOxygenSaturation) {
//     oxygenSaturation = newOxygenSaturation;
//     notifyListeners();
//   }
//
//   void updateBloodGlucoseLevel(int newBloodGlucoseLevel) {
//     bloodGlucoseLevel = newBloodGlucoseLevel;
//     notifyListeners();
//   }
// }