import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/k_services/diagnoseEngine.dart';
import 'package:heathtrack/k_services/getEachHealthData.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/services/localNotifications.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:heathtrack/widgets/updatePatientInfoView.dart';
import 'package:provider/provider.dart';
import 'updateInfoView.dart';

class PatientCard extends StatefulWidget {
  PatientCard(
      {super.key,
      required this.name,
      this.age,
      required this.ontap,
      this.isWoman = false,
      required this.diagnose,
      required this.patient});

  String name;
  int? age;
  final Function ontap;
  var isWoman = false;
  Patient patient;
  String diagnose;

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
//   String? diagnose = '';

// //status: 0 :tốt, 1: cảnh báo, 2: nguy hiểm
//   var heartRateStatus = 0;
//   var bloodPressureStatus = 0;
//   var bodyTemperatureStatus = 0;
//   var oxygenSaturationStatus = 0;
//   var bloodGlucoseLevelStatus = 0;
//   var overviewStatus = 0;
//   updateStatus() {
//     String diagnoseBloodPressureIssue =
//         (healthDataList[healthDataList.length - 1].spb != null &&
//                 healthDataList[healthDataList.length - 1].dbp != null)
//             ? DiagnosisEngine.diagnoseBloodPressureIssue(
//                 healthDataList[healthDataList.length - 1].spb! as int,
//                 healthDataList[healthDataList.length - 1].dbp! as int)
//             : '';
//     switch (diagnoseBloodPressureIssue) {
//       case "Optimal blood pressure":
//         heartRateStatus = 0;
//         break;
//       case "Normal blood pressure":
//         heartRateStatus = 0;
//         break;
//       case "Prehypertension":
//         heartRateStatus = 1;
//         break;
//       case "Hypertension stage 1":
//         heartRateStatus = 1;
//         break;
//       case "Hypertension stage 2":
//         heartRateStatus = 2;
//         break;
//       case "Hypertension stage 3":
//         heartRateStatus = 2;
//         break;
//       case "Isolated systolic hypertension":
//         heartRateStatus = 1;
//         break;
//       default:
//         heartRateStatus = -1;
//         break;
//     }

//     String diagnoseHeartRateIssue =
//         healthDataList[healthDataList.length - 1].heartRate != null
//             ? DiagnosisEngine.diagnoseHeartRateIssue(
//                 healthDataList[healthDataList.length - 1].heartRate! as int)
//             : '';
//     switch (diagnoseHeartRateIssue) {
//       case 'Low heart rate':
//         heartRateStatus = 1;
//         break;
//       case 'Normal heart rate':
//         heartRateStatus = 0;
//         break;
//       case 'High heart rate':
//         heartRateStatus = 1;
//         break;
//       case 'Dangerous':
//         heartRateStatus = 2;
//         break;
//       default:
//         heartRateStatus = -1;
//         break;
//     }
//     String diagnoseBloodGlucoseLevelIssue =
//         healthDataList[healthDataList.length - 1].glucose != null
//             ? DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(
//                 healthDataList[healthDataList.length - 1].glucose! as double)
//             : '';
//     switch (diagnoseBloodGlucoseLevelIssue) {
//       case 'Low blood glucose level':
//         bloodGlucoseLevelStatus = 1;
//         break;
//       case 'Normal blood glucose level':
//         bloodGlucoseLevelStatus = 0;
//         break;
//       case 'High blood glucose level':
//         bloodGlucoseLevelStatus = 1;
//         break;
//       default:
//         bloodGlucoseLevelStatus = -1;
//         break;
//     }
//     String diagnoseTemperatureIssue =
//         healthDataList[healthDataList.length - 1].temperature != null
//             ? DiagnosisEngine.diagnoseTemperatureIssue(
//                 healthDataList[healthDataList.length - 1].temperature!)
//             : '';
//     switch (diagnoseTemperatureIssue) {
//       case 'Low body temperature':
//         bodyTemperatureStatus = 1;
//         break;
//       case 'Normal body temperature':
//         bodyTemperatureStatus = 0;
//         break;
//       case 'High body temperature':
//         bodyTemperatureStatus = 1;
//         break;
//       default:
//         bodyTemperatureStatus = -1;
//         break;
//     }
//     String diagnoseOxygenSaturationIssue =
//         healthDataList[healthDataList.length - 1].oxygen != null
//             ? DiagnosisEngine.diagnoseOxygenSaturationIssue(
//                 healthDataList[healthDataList.length - 1].oxygen!)
//             : '';
//     switch (diagnoseOxygenSaturationIssue) {
//       case 'Low oxygen saturation':
//         oxygenSaturationStatus = 1;
//         break;
//       case 'Normal oxygen saturation':
//         oxygenSaturationStatus = 0;
//         break;
//       case 'High oxygen saturation':
//         oxygenSaturationStatus = 1;
//         break;
//       default:
//         oxygenSaturationStatus = -1;
//         break;
//     }

//     //overviewStatus = 0;

//     print(heartRateStatus);
//   }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1))
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
            ),
            borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1 / 1.2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.4),
                    image: DecorationImage(
                        image: AssetImage(
                          widget.isWoman
                              ? 'images/womanAvatar.png'
                              : 'images/manAvatar.png',
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (widget.age == null)
                          ? 'Age: No information'
                          : 'Age: ${widget.age}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Diagnose: ${widget.name}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateInfoView(
                                patientId: widget.patient.id,
                              )));
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    color: Colors.grey.shade600,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdatePatientInfoView(
                                patientId: widget.patient.id,
                                patientName: widget.patient.name,
                                patientPassword: widget.patient.password,
                              )));
                    },
                    icon: const Icon(
                      Icons.published_with_changes,
                      size: 30,
                    ),
                    color: Colors.grey.shade600,
                  ),
                  TextButton(
                      onPressed: () {
                        WatcherService().deletePatient(
                            context: context, userId: widget.patient.id);
                      },
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Color(0xffb93939)),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
