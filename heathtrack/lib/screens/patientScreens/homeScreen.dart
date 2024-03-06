import 'package:flutter/material.dart';
import 'package:heathtrack/screens/patientScreens/sosScreen.dart';
import 'package:heathtrack/widgets/healthIndicators.dart';
import 'package:provider/provider.dart';
import '../../objects/patient.dart';
import '../../widgets/HorizontalBar.dart';
import '../../widgets/Summary.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Patient>(
      builder: (BuildContext context, patient,child) {
      return Scaffold(
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
                child: HealthIndicators(patient: patient,),
              ),
                  HorizontalBar(const Icon(Icons.emergency,color: Colors.red,),'Emergency',
                    ontap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SosScreen()));
                    },),
                  HorizontalBar(const Icon(Icons.apple,color: Colors.greenAccent,),'Nutritions', ontap: (){},),
                  HorizontalBar(const Icon(Icons.spa_outlined,color: Colors.blueAccent,),'BMI', ontap: (){},),
                  const SizedBox(height: 30,)
                ],
              ),
            ),
          ),
        ); },
    );
  }
}



