class HealthData {
   String id;
   String userId;
   int systolic; // huyết áp tâm thu - huyết áp tối đa
   int diastolic; // huyết áp tâm trương - huyết áp tối thiểu
   double spo2;
   int heartRate;
   double bloodGlucoseLevel;
   double temperature;
   DateTime recordedAt;

  HealthData({
    required this.id,
    required this.userId,
    required this.systolic,
    required this.diastolic,
    required this.spo2,
    required this.heartRate,
    required this.bloodGlucoseLevel,
    required this.temperature,
    required this.recordedAt,
  });
  void updateTemperature(double newTemperature) {
    temperature = newTemperature;
    recordedAt = DateTime.now();
  }
   void updateHeartRate(int newHeartRate) {
     heartRate = newHeartRate;
     recordedAt = DateTime.now();
   }
   void updateSpo2(double newSpo2) {
     spo2 = newSpo2;
     recordedAt = DateTime.now();
   }
   void updateBloodGlucoseLevel(double newBloodGlucoseLevel) {
     bloodGlucoseLevel = newBloodGlucoseLevel;
     recordedAt = DateTime.now();
   }
   void updateBloodPressure(List<int> newBloodPressure) {
     systolic = newBloodPressure[0];
     diastolic = newBloodPressure[1];
     recordedAt = DateTime.now();
   }
}