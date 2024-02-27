import 'package:flutter/material.dart';

import '../../objects/patient.dart';

class DetailPatientInfoScreen extends StatelessWidget {
  DetailPatientInfoScreen({super.key, required this.patient});
  Patient patient;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${patient.name}\'s information'),
      ),
      body: Container(

      ),
    );
  }
}
