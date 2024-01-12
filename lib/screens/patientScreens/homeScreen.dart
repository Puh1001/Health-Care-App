import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/screens/patientScreens/oxygenScreen.dart';
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
                    const Text("Health Metrics",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    const SizedBox(height: 5,),
                    Row(
                      children: [
                        Metrics(const Icon(
                          FontAwesomeIcons.heartPulse,
                          color: Colors.green,size: 45,),
                          "Heart Rate",
                          "${patient.heartRate}",
                          'bpm',
                          ontap: (){},),
                        const SizedBox(width: 15,),
                        Metrics(const Icon(
                          FontAwesomeIcons.droplet ,
                          color: Colors.redAccent,
                          size: 50,),
                          "Blood\nPressure",
                          "${patient.bloodPressure}",
                          'mmHg',
                          ontap: (){},),
                      ],
                    ),
                    const SizedBox(height: 15,),
                    Row(
                      children: [
                        Metrics(const Icon(
                          FontAwesomeIcons.o,color: Colors.blueAccent,size: 50,),
                          "Oxygen\nSaturation",
                          "${patient.oxygenSaturation}",
                          '%',
                          ontap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=> const OxygenScreen()));
                          },
                        ),
                        const SizedBox(width: 15,),
                        Metrics(const Icon(
                          FontAwesomeIcons.temperatureFull,
                          color: Colors.orange,size: 50,),
                          "Body\nTemperature","${patient.bodyTemperature}",
                          'oC',
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
                          const Icon(FontAwesomeIcons.borderNone,color: Colors.yellow,size: 50,),
                          "",
                          "",
                          '',
                          ontap: (){},),
                        const SizedBox(width: 15,),
                        Metrics(
                          const Icon(FontAwesomeIcons.borderNone,color: Colors.purple,size: 50,),
                          "",
                          "",
                          '',
                          ontap: (){},),
                      ],
                    ),
                  ],
                ),
              ),
                  HorizontalBar(const Icon(Icons.apple,color: Colors.greenAccent,),'Nutritions'),
                  HorizontalBar(const Icon(Icons.directions_walk,color: Colors.orange,),'Activities',),
                  HorizontalBar(const Icon(Icons.bed,color: Colors.blueAccent,),'Sleep'),
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



