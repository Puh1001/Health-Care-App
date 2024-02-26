import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../widgets/Metrics.dart';
import '../patientScreens/oxygenScreen.dart';
import '../patientScreens/temperatureScreen.dart';
class PatientMornitoringScreen extends StatelessWidget {
  const PatientMornitoringScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Health information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    boxShadow: [BoxShadow(
                        offset: Offset(0,4),
                        blurRadius: 10,
                        color: Colors.grey.shade300
                    )],
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey.shade400
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                        child: Container()),
                    const SizedBox(width: 10,),
                    const Expanded(
                        flex: 5,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nguyen Van A',
                              style: TextStyle(fontSize: 20,
                                  fontWeight: FontWeight.bold),),
                            Text('Age: 55',
                              style: TextStyle(fontSize: 16,color: Colors.black54),),
                            Text('Phone number: 0987654321',
                              style: TextStyle(fontSize: 16,color: Colors.black54),),
                            Row(
                              children: [
                                Icon(Icons.check_circle_outline,color: Colors.white,),
                                const SizedBox(width: 5,),
                                Text('Diagnose: Normal',
                                  style: TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 30,),
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
                        ontap: (){},),
                      const SizedBox(width: 15,),
                      Metrics(const Icon(
                        FontAwesomeIcons.droplet ,
                        color: Colors.white,
                        size: 40,),
                        "Blood\nPressure",
                        "125",
                        'mmHg',
                        background: Color(0xffF7CECD),
                        ontap: (){},),
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
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const TemperatureScreen()));
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
                        ontap: (){},),
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
              const SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
