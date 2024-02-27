import 'package:flutter/material.dart';
import 'package:heathtrack/screens/watcherScreen/detailPatientInfoScreen.dart';
import 'package:heathtrack/widgets/healthIndicators.dart';

import '../../objects/patient.dart';
class PatientMornitoringScreen extends StatelessWidget {
  Patient patient;
  PatientMornitoringScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Health information'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context)=>DetailPatientInfoScreen(patient: patient)));
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(
                          offset: const Offset(0,4),
                          blurRadius: 10,
                          color: Colors.grey.shade300
                      )],
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade400
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                              child: AspectRatio(
                                aspectRatio: 1/1.2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              )),
                          const SizedBox(width: 10,),
                          Expanded(
                              flex: 5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(patient.name,
                                    style: const TextStyle(fontSize: 20,
                                        fontWeight: FontWeight.bold),),
                                  Text('ID: ${patient.id}',
                                    style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                  Text((patient.dateOfBirth ==null)?'Age: No information':'Age:  ${DateTime.now().year - patient.dateOfBirth!.year}',
                                    style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                  Text('Phone number: ${patient.phoneNumber ?? 'No information'}',
                                    style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                ],
                              )),
                        ],
                      ),
                      const SizedBox(height: 10,),
                      Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.check_circle_outline,color: Colors.white,),
                          const SizedBox(width: 5,),
                          Text('Diagnose: ${patient.diagnose}',
                            style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30,),
              HealthIndicators(patient: patient),
              const SizedBox(height: 30,),
            ]
      ),))
    );
  }
}
