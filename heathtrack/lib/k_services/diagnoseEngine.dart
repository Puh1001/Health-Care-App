import 'package:heathtrack/providers/userProvider.dart';
import 'package:provider/provider.dart';

class DiagnosisEngine {
  // chẩn đoán vấn đề huyết áp
  static String diagnoseBloodPressureIssue(int systolic, int diastolic) {
    if (systolic==0 && diastolic==0 ) return '';
    if (systolic < 120 && diastolic < 80) {
      return "Optimal blood pressure";
    } else if (systolic >= 120 && systolic < 130 && diastolic >= 80 && diastolic < 85) {
      return "Normal blood pressure";
    } else if (systolic >= 130 && systolic < 140 && diastolic >= 85 && diastolic < 90) {
      return "Prehypertension";
    } else if (systolic >= 140 && systolic < 150 && diastolic >= 90 && diastolic < 100) {
      return "Hypertension stage 1";
    } else if (systolic >= 150 && systolic < 160 && diastolic >= 100 && diastolic < 110) {
      return "Hypertension stage 2";
    } else if (systolic >= 160 && systolic < 180 && diastolic >= 110 && diastolic < 120) {
      return "Hypertension stage 3";
    } else if (systolic >= 180 && diastolic >= 120) {
      return "Hypertension stage 3";
    } else if (systolic >= 140 && diastolic < 90) {
      return "Isolated systolic hypertension";
    } else {
      return "Unable to diagnose blood pressure.";
    }
  }


  // chẩn đoán vấn đề nhịp tim
  static String diagnoseHeartRateIssue(int heartRate) {
    if (heartRate==0) return '';
    if (heartRate < 50) {
      return 'Dangerous';
    } else if (heartRate < 60) {
      return 'Low heart rate';
    } else if (heartRate > 100) {
      return 'High heart rate';
    } else {
      return 'Normal heart rate';
    }
  }

  // chẩn đoán vấn đề nồng độ đường huyết
  static String diagnoseBloodGlucoseLevelIssue(double bloodGlucoseLevel) {
    if (bloodGlucoseLevel==0) return '';
    if (bloodGlucoseLevel < 70) {
      return 'Low blood glucose level';
    } else if (bloodGlucoseLevel > 140) {
      return 'High blood glucose level';
    } else {
      return 'Normal blood glucose level';
    }
  }

  // chẩn đoán vấn đề nhiệt độ cơ thể
  static String diagnoseTemperatureIssue(double temperature) {
    if (temperature==0) return '';
    if (temperature < 36.1) {
      return 'Low body temperature';
    } else if (temperature > 37.2) {
      return 'High body temperature';
    } else {
      return 'Normal body temperature';
    }
  }

  // chẩn đoán vấn đề nồng độ o2
  static String diagnoseOxygenSaturationIssue(double oxygenSaturation) {
    if (oxygenSaturation==0) return '';
    if (oxygenSaturation < 90) {
      return 'Low oxygen saturation';
    } else if (oxygenSaturation > 100) {
      return 'High oxygen saturation';
    } else {
      return 'Normal oxygen saturation';
    }
  }

  //chẩn đoán chung về sức khỏe
  static String diagnoseHealth(double temperature, List<int> bloodPressure, int heartRate, double bloodGlucoseLevel, double bloodOxygenLevel) {
    String diagnosis = '';
    if (temperature >= 37.0 && bloodPressure[0] >= 140 && bloodPressure[1] >= 90 && heartRate >= 100 && bloodGlucoseLevel >= 200 && bloodOxygenLevel < 95) {
      diagnosis = 'sức khỏe tốt';
    } else if (temperature >= 38.0 && bloodPressure[0] >= 140 && bloodPressure[1] >= 90) {
      diagnosis = 'sốt cao và cao huyết áp';
    } else if (bloodPressure[0] >= 140 && bloodPressure[1] >= 90 && bloodOxygenLevel < 95) {
      diagnosis = 'cao huyết áp và thiếu oxi';
    } else if (temperature >= 38.0 && bloodOxygenLevel < 95) {
      diagnosis = 'sốt cao và thiếu oxi';
    } else {
      diagnosis = 'Sức khỏe bình thường';
    }

    return diagnosis;
  }
  static double calculateBMI(double weight, double height){
    return double.parse((weight/(height*height/10000)).toStringAsFixed(2));
  }
  static String diagnoseBMI(double bmi) {
    if (bmi < 18.5) {
      return "skinny";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "normal";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "overweight";
    } else {
      return "obese";
    }
  }
}