import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../objects/patient.dart';
import '../screens/patientScreens/bloodPressureScreen.dart';
import '../screens/patientScreens/glucoseLevelScreen.dart';
import '../screens/patientScreens/heartRateScreen.dart';
import '../screens/patientScreens/oxygenScreen.dart';
import '../screens/patientScreens/temperatureScreen.dart';
import 'Metrics.dart';
class HealthIndicators extends StatelessWidget {
  HealthIndicators({super.key, required this.patient});
  Patient patient;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Health indicators',
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey,
              fontSize: 18),),
        const SizedBox(height: 5,),
        Row(
          children: [
            Metrics(const Icon(
              FontAwesomeIcons.heartPulse,
              color: Colors.white,
              size: 35,),
              "Heart Rate",
              "${patient.heartRate}",
              'bpm',
              background: const Color(0xffD4F4DC),
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  HeartRateScreen()));
              },),
            const SizedBox(width: 15,),
            Metrics(const Icon(
              FontAwesomeIcons.droplet ,
              color: Colors.white,
              size: 40,),
              "Blood\nPressure",
              "${patient.bloodPressure}",
              'mmHg',
              background: Color(0xffF7CECD),
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  BloodPressureScreen()));
              },),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            Metrics(const Icon(
              FontAwesomeIcons.o,
              color: Colors.white,
              size: 40,
            ),
              "Oxygen\nSaturation",
              "${patient.oxygenSaturation}",
              '%',
              background: Color(0xffD4E3F4),
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  OxygenScreen()));
              },
            ),
            const SizedBox(width: 15,),
            Metrics(const Icon(
              FontAwesomeIcons.temperatureFull,
              color: Colors.white,
              size: 40,
            ) as Icon,
              "Body\nTemperature",
              "${patient.bodyTemperature}",
              '°C',
              background:Color(0xffF4EDD4),
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> TemperatureScreen()));
              },
            ),
          ],
        ),
        const SizedBox(height: 15,),
        Row(
          children: [
            Metrics(
              const Icon(FontAwesomeIcons.g,color: Colors.white,size: 45,),
              "Glucose\nlevel",
              "${patient.bloodGlucoseLevel}",
              'mg/DL',
              background: Color(0xffDAD4F4),
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>  GlucoseLevelScreen()));
              },),
            const SizedBox(width: 15,),
            Metrics(
              const Icon(FontAwesomeIcons.personRunning,color: Colors.white,size: 50,),
              "Activity",
              "1120",
              'steps',
              background: const Color(0xffD2D8DE),
              ontap: (){},),
          ],
        ),
      ],
    );
  }
}
