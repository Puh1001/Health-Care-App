import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../objects/patient.dart';
import '../../widgets/InforBar.dart';

class DetailPatientInfoScreen extends StatelessWidget {
  DetailPatientInfoScreen({super.key, required this.patient});
  Patient patient;
  var image = 'images/avatar.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.name}\'s information'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color(0xfff7f7f7),
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Colors.white,
                  child: Stack(
                    children: [
                      SizedBox(
                        height: 150,
                        width: 150,
                        child: ClipOval(
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                shortenName(patient.name),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              InforBar('Main Information', [
                Infor(
                  'Name',
                  patient.name,
                  onTouch: (){},
                  canEdit: false,
                ),
                Infor(
                  'Gender',
                  "${patient.gender}",
                  canEdit: false, onTouch: (){},
                ),
                Infor(
                  'Date of Birth',
                  (patient.dateOfBirth == null)
                      ? 'No information'
                      : DateFormat('dd/MM/yyyy').format(patient.dateOfBirth!),
                  onTouch: (){},
                  canEdit: false,
                ),
              ]),
              InforBar('Communications', [
                Infor(
                  'Phone number',
                  "${patient.phoneNumber}",
                  canEdit: false,
                  onTouch: () {},
                ),
                Infor(
                  'Email',
                  "${patient.email}",
                  canEdit: false, onTouch: (){},
                ),
              ]),
              InforBar('Body indicators', [
                Infor(
                  'Height (cm)',
                  '${patient.height}',
                  canEdit: false,
                  onTouch: () {}
                ),
                Infor(
                  'Weight (kg)',
                  '${patient.weight}',
                  canEdit: false,
                  onTouch: () {}
                ),
                Infor(
                  'BMI',
                  (patient.weight != null && patient.height != null)
                      ? '${DiagnosisEngine.calculateBMI(patient.weight!, patient.height!)} (${DiagnosisEngine.diagnoseBMI(DiagnosisEngine.calculateBMI(patient.weight!, patient.height!))})'
                      : 'no information',
                  canEdit: false, onTouch: (){},
                )
              ])
            ],
          ),
        ),
      ),
    );
  }
}

  String shortenName(String fullName) {
    String shortenName;
    fullName = fullName.trim();
    if (fullName.contains(" ")) {
      String startString = fullName.substring(0, fullName.indexOf(' '));
      String endString = fullName.substring(fullName.lastIndexOf(' ') + 1);
      shortenName = "$startString $endString";
    } else {
      shortenName = fullName;
    }
    return shortenName;
  }

