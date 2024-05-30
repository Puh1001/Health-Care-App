import 'package:test/test.dart';
import 'package:heathtrack/k_services/diagnoseEngine.dart';

void main() {
  group('DiagnosisEngine', () {
    test('diagnoseBloodPressureIssue', () {
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(110, 70),
          "Optimal blood pressure");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(125, 82),
          "Normal blood pressure");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(135, 87),
          "Prehypertension");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(145, 95),
          "Hypertension stage 1");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(155, 105),
          "Hypertension stage 2");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(165, 115),
          "Hypertension stage 3");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(185, 125),
          "Hypertension stage 3");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(145, 85),
          "Isolated systolic hypertension");
      expect(DiagnosisEngine.diagnoseBloodPressureIssue(0, 0), '');
    });

    test('diagnoseHeartRateIssue', () {
      expect(DiagnosisEngine.diagnoseHeartRateIssue(0), '');
      expect(DiagnosisEngine.diagnoseHeartRateIssue(55), 'Low heart rate');
      expect(DiagnosisEngine.diagnoseHeartRateIssue(75), 'Normal heart rate');
      expect(DiagnosisEngine.diagnoseHeartRateIssue(110), 'High heart rate');
      expect(DiagnosisEngine.diagnoseHeartRateIssue(160), 'Dangerous');
    });

    test('diagnoseBloodGlucoseLevelIssue', () {
      expect(DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(0), '');
      expect(DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(60),
          'Low blood glucose level');
      expect(DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(100),
          'Normal blood glucose level');
      expect(DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(150),
          'High blood glucose level');
    });

    test('diagnoseTemperatureIssue', () {
      expect(DiagnosisEngine.diagnoseTemperatureIssue(0), '');
      expect(DiagnosisEngine.diagnoseTemperatureIssue(35.5),
          'Low body temperature');
      expect(DiagnosisEngine.diagnoseTemperatureIssue(36.5),
          'Normal body temperature');
      expect(DiagnosisEngine.diagnoseTemperatureIssue(38.5),
          'High body temperature');
    });

    test('diagnoseOxygenSaturationIssue', () {
      expect(DiagnosisEngine.diagnoseOxygenSaturationIssue(0), '');
      expect(DiagnosisEngine.diagnoseOxygenSaturationIssue(85),
          'Low oxygen saturation');
      expect(DiagnosisEngine.diagnoseOxygenSaturationIssue(95),
          'Normal oxygen saturation');
      expect(DiagnosisEngine.diagnoseOxygenSaturationIssue(101),
          'High oxygen saturation');
    });

    test('calculateBMI', () {
      expect(DiagnosisEngine.calculateBMI(70, 175), closeTo(22.86, 0.01));
      expect(DiagnosisEngine.calculateBMI(80, 180), closeTo(24.69, 0.01));
    });

    test('diagnoseBMI', () {
      expect(DiagnosisEngine.diagnoseBMI(18.0), "skinny");
      expect(DiagnosisEngine.diagnoseBMI(22.0), "normal");
      expect(DiagnosisEngine.diagnoseBMI(27.0), "overweight");
      expect(DiagnosisEngine.diagnoseBMI(32.0), "obese");
    });
  });
}
