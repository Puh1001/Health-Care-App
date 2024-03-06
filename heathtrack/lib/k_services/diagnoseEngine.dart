class DiagnosisEngine {
  // chẩn đoán vấn đề huyết áp
  static String diagnoseBloodPressureIssue(int systolic, int diastolic) {
    if (systolic < 120 && diastolic < 80) {
      return "Huyết áp tối ưu";
    } else if (systolic >= 120 && systolic < 130 && diastolic >= 80 && diastolic < 85) {
      return "Huyết áp bình thường";
    } else if (systolic >= 130 && systolic < 140 && diastolic >= 85 && diastolic < 90) {
      return "Tiền tăng huyết áp";
    } else if (systolic >= 140 && systolic < 150 && diastolic >= 90 && diastolic < 100) {
      return "Tăng huyết áp độ 1";
    } else if (systolic >= 150 && systolic < 160 && diastolic >= 100 && diastolic < 110) {
      return "Tăng huyết áp độ 2";
    } else if (systolic >= 160 && systolic < 180 && diastolic >= 110 && diastolic < 120) {
      return "Tăng huyết áp độ 3";
    } else if (systolic >= 180 && diastolic >= 120) {
      return "Tăng huyết áp độ 3";
    } else if (systolic >= 140 && diastolic < 90) {
      return "Tăng huyết áp tâm thu đơn độc";
    } else {
      return "Không thể chẩn đoán huyết áp.";
    }
  }

  // chẩn đoán vấn đề nhịp tim
  static String diagnoseHeartRateIssue(int heartRate) {
    return 'good';
  }

  // chẩn đoán vấn đề nồng độ đường huyết
  static String diagnoseBloodGlucoseLevelIssue(double bloodGlucoseLevel) {
    return 'good';
  }

  //chẩn đoán vấn đề nhiệt độ cơ thể
  static String diagnoseTemperatureIssue(double temperature) {
    return 'good';
  }

  //chẩn đoán vấn đề nồng độ o2
  static String diagnoseOxygenSaturationIssue(double temperature) {
    return 'good';
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
    return weight/(height*height);
  }
  static String diagnoseBMI(double bmi) {
    if (bmi < 18.5) {
      return "Gầy";
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return "Bình thường";
    } else if (bmi >= 25 && bmi <= 29.9) {
      return "Thừa cân";
    } else {
      return "Béo phì";
    }
  }
}