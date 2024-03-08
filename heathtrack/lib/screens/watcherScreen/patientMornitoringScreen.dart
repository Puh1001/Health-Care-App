import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/watcherScreen/detailPatientInfoScreen.dart';
import 'package:heathtrack/widgets/healthIndicators.dart';
import 'package:provider/provider.dart';

import '../../models/heathData.dart';
import '../../objects/patient.dart';
class PatientMornitoringScreen extends StatelessWidget {
  Patient patient;
  PatientMornitoringScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,user,child){
      return Scaffold(
          backgroundColor: user.theme.backgroundColor1,
        appBar: AppBar(
          backgroundColor: user.theme.backgroundColor1,
          foregroundColor: user.theme.textColor1,
          title: Text(user.lang.healthInformationTitle),
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
                            color: Colors.black.withOpacity(0.1)
                        )],
                      borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFFBEA2FF), Color(0xFFF5CCCC),Color(0xFF9EFFF4),],
                        ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                                child: AspectRatio(
                                  aspectRatio: 1/1.2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.5),
                                      borderRadius: BorderRadius.circular(15),
                                        image:  DecorationImage(
                                            image: AssetImage(patient.gender=='female'?'images/womanAvatar.png':'images/manAvatar.png',),
                                            fit: BoxFit.fitHeight
                                        )
                                    ),
                                  ),
                                )),
                            const SizedBox(width: 10,),
                            Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(patient.name,
                                      style: const TextStyle(fontSize: 20,
                                          fontWeight: FontWeight.bold),),
                                    Text('ID: ${patient.id}',
                                      style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                    Text((patient.dateOfBirth ==null)?'${user.lang.age}: ${user.lang.noInformation}':'${user.lang.age}:  ${DateTime.now().year - patient.dateOfBirth!.year}',
                                      style: const TextStyle(fontSize: 16,color: Colors.black54),),
                                    Text('${user.lang.phoneNumber}:${patient.phoneNumber ?? user.lang.noInformation}',
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
                            Text('${user.lang.diagnose}: ${patient.diagnose}',
                              style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30,),
                HealthIndicators(heathData:patient.healthDataList.isEmpty?
                HeathData(heartRate: 0, spb: 0, dbp: 0, oxygen: 0, temperature: 0, glucose: 0, step: 0, timestamp: DateTime.now())
                    :patient.healthDataList[patient.healthDataList.length -1],),
                const SizedBox(height: 30,),
              ]
        ),))
      );}
    );
  }
}
