import 'dart:js';

import 'package:heathtrack/k_services/diagnoseEngine.dart';
import 'package:heathtrack/models/heathData.dart';
import 'package:heathtrack/models/patientInWatcher.dart';

import '../models/user.dart';

class Patient extends User {
  String watcherId;
  String? phoneNumber;
  DateTime? dateOfBirth;
  String? gender;
  double? height;
  double? weight;
  List<HeathData> healthDataList = [];

  // int? heartRate =0;
  // int? systolic = 0;
  // int? diastolic = 0;
  // double? bodyTemperature =0;
  // double? oxygenSaturation =0;
  // double? bloodGlucoseLevel =0;
  String? diagnose = '';

  //status: 0 :tốt, 1: cảnh báo, 2: nguy hiểm
  var heartRateStatus = 0;
  var bloodPressureStatus = 0;
  var bodyTemperatureStatus = 0;
  var oxygenSaturationStatus = 0;
  var bloodGlucoseLevelStatus = 0;
  var overviewStatus = 0;
  Patient(
      {required String id,
      required String name,
      required String email,
      required String password,
      required String familyCode,
      required String address,
      required String type,
      required String token,
      required this.watcherId,
      this.phoneNumber,
      this.dateOfBirth,
      this.gender,
      this.height,
      this.weight,
      // this.heartRate,
      // this.systolic,
      // this.diastolic,
      // this.bodyTemperature,
      // this.oxygenSaturation,
      // this.bloodGlucoseLevel,
      this.diagnose,
      this.healthDataList = const []})
      : super(
          id: id,
          name: name,
          email: email,
          password: password,
          familyCode: familyCode,
          address: address,
          type: type,
          token: token,
        );
  getDataFromPatientInWatcher(PatientInWatcher p) {
    name = p.name;
    email = p.email;
    password = p.password;
    type = p.type;
    id = p.id ?? '';
    //=p.age;
    familyCode = p.familyCode;
    watcherId = p.watcherId;
  }

  updateStatus() {
    String diagnoseBloodPressureIssue =
        (healthDataList[healthDataList.length - 1].spb != null &&
                healthDataList[healthDataList.length - 1].dbp != null)
            ? DiagnosisEngine.diagnoseBloodPressureIssue(
                healthDataList[healthDataList.length - 1].spb! as int,
                healthDataList[healthDataList.length - 1].dbp! as int)
            : '';
    switch (diagnoseBloodPressureIssue) {
      case "Optimal blood pressure":
        heartRateStatus = 0;
        break;
      case "Normal blood pressure":
        heartRateStatus = 0;
        break;
      case "Prehypertension":
        heartRateStatus = 1;
        break;
      case "Hypertension stage 1":
        heartRateStatus = 1;
        break;
      case "Hypertension stage 2":
        heartRateStatus = 2;
        break;
      case "Hypertension stage 3":
        heartRateStatus = 2;
        break;
      case "Isolated systolic hypertension":
        heartRateStatus = 1;
        break;
      default:
        heartRateStatus = -1;
        break;
    }

    String diagnoseHeartRateIssue =
        healthDataList[healthDataList.length - 1].heartRate != null
            ? DiagnosisEngine.diagnoseHeartRateIssue(
                healthDataList[healthDataList.length - 1].heartRate! as int)
            : '';
    switch (diagnoseHeartRateIssue) {
      case 'Low heart rate':
        heartRateStatus = 1;
        break;
      case 'Normal heart rate':
        heartRateStatus = 0;
        break;
      case 'High heart rate':
        heartRateStatus = 1;
        break;
      case 'Dangerous':
        heartRateStatus = 2;
        break;
      default:
        heartRateStatus = -1;
        break;
    }
    String diagnoseBloodGlucoseLevelIssue =
        healthDataList[healthDataList.length - 1].glucose != null
            ? DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(
                healthDataList[healthDataList.length - 1].glucose! as double)
            : '';
    switch (diagnoseBloodGlucoseLevelIssue) {
      case 'Low blood glucose level':
        bloodGlucoseLevelStatus = 1;
        break;
      case 'Normal blood glucose level':
        bloodGlucoseLevelStatus = 0;
        break;
      case 'High blood glucose level':
        bloodGlucoseLevelStatus = 1;
        break;
      default:
        bloodGlucoseLevelStatus = -1;
        break;
    }
    String diagnoseTemperatureIssue =
        healthDataList[healthDataList.length - 1].temperature != null
            ? DiagnosisEngine.diagnoseTemperatureIssue(
                healthDataList[healthDataList.length - 1].temperature!)
            : '';
    switch (diagnoseTemperatureIssue) {
      case 'Low body temperature':
        bodyTemperatureStatus = 1;
        break;
      case 'Normal body temperature':
        bodyTemperatureStatus = 0;
        break;
      case 'High body temperature':
        bodyTemperatureStatus = 1;
        break;
      default:
        bodyTemperatureStatus = -1;
        break;
    }
    String diagnoseOxygenSaturationIssue =
        healthDataList[healthDataList.length - 1].oxygen != null
            ? DiagnosisEngine.diagnoseOxygenSaturationIssue(
                healthDataList[healthDataList.length - 1].oxygen!)
            : '';
    switch (diagnoseOxygenSaturationIssue) {
      case 'Low oxygen saturation':
        oxygenSaturationStatus = 1;
        break;
      case 'Normal oxygen saturation':
        oxygenSaturationStatus = 0;
        break;
      case 'High oxygen saturation':
        oxygenSaturationStatus = 1;
        break;
      default:
        oxygenSaturationStatus = -1;
        break;
    }

    //overviewStatus = 0;
  }
}
