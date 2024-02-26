import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/screens/patientScreens/bloodPressureScreen.dart';
import 'package:heathtrack/screens/patientScreens/glucoseLevelScreen.dart';
import 'package:heathtrack/screens/patientScreens/heartRateScreen.dart';
import 'package:heathtrack/screens/patientScreens/oxygenScreen.dart';
import 'package:heathtrack/screens/patientScreens/sosScreen.dart';
import 'package:heathtrack/screens/patientScreens/temperatureScreen.dart';
import 'package:provider/provider.dart';
import '../../objects/patient.dart';
import '../../widgets/HorizontalBar.dart';
import '../../widgets/Metrics.dart';
import '../../widgets/Summary.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patient>(
      builder: (BuildContext context, patient,child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color(0xfff7f7f7),
          body: Center(
            child:
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 40,),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                            onPressed: (){
                            },
                            icon: const Icon(Icons.settings,size: 30,)),
                        const SizedBox(width:5)
                      ]),
                  GestureDetector(
                      onTap: (){},
                      child: SummaryWG()
                  ),
              Container(
                margin: const EdgeInsets.all(20),
                padding: const EdgeInsets.only(top:20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
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
                              "101",
                              'bpm',
                              background: Color(0xffD4F4DC),
                              ontap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>  HeartRateScreen()));
                              },),
                            const SizedBox(width: 15,),
                            Metrics(const Icon(
                              FontAwesomeIcons.droplet ,
                              color: Colors.white,
                              size: 40,),
                              "Blood\nPressure",
                              "125",
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
                              "98",
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
                              "Body\nTemperature","37.3",
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
                              "138",
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
                              background: Color(0xffD2D8DE),
                              ontap: (){},),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
                  HorizontalBar(const Icon(Icons.emergency,color: Colors.red,),'Emergency',
                    ontap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SosScreen()));
                    },),
                  HorizontalBar(const Icon(Icons.apple,color: Colors.greenAccent,),'Nutritions', ontap: (){},),
                  HorizontalBar(const Icon(Icons.bed,color: Colors.blueAccent,),'Sleep', ontap: (){},),
                  const SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ),
      ); },
    );
  }
}



