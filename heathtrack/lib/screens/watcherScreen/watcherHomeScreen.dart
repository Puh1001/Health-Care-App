import 'package:flutter/material.dart';
import 'package:heathtrack/screens/watcherScreen/patientMornitoringScreen.dart';
import 'package:heathtrack/widgets/patientCard.dart';

import '../../objects/patient.dart';
import '../../widgets/deviceCard.dart';
class WatcherHomeScreen extends StatefulWidget {
  const WatcherHomeScreen({super.key});

  @override
  State<WatcherHomeScreen> createState() => _WatcherHomeScreenState();
}

class _WatcherHomeScreenState extends State<WatcherHomeScreen> {
  List<Patient> listPatient=[
    Patient(name: 'Nguyen Van A', dateOfBirth: DateTime(1970,12,11), sex: "male", id: '',diagnose: "Good!",
    heartRate: 122,
    bloodGlucoseLevel: 30,
    bloodPressure: 55,
    bodyTemperature: 38,
    oxygenSaturation: 97,
    ),
    Patient(name: 'Nguyen Van B', sex: "male", id: ''),
    Patient(name: 'Nguyen Van C', dateOfBirth: DateTime(1977,12,11), sex: "male", id: ''),
    Patient(name: 'Nguyen Van D', dateOfBirth: DateTime(1955,12,11), sex: "male", id: ''),
  ];
  bool mySwitch = true;
  TextEditingController patientName = TextEditingController();
  TextEditingController patientUsername = TextEditingController();
  TextEditingController patientPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
              elevation: 5,
              isScrollControlled: true,
              context: context, builder: (context)=>SingleChildScrollView(
                child: Container(
                padding:  EdgeInsets.only(top:20, left: 20,right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom+ 20),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      topLeft: Radius.circular(20),
                    )
                ),
                width: MediaQuery.sizeOf(context).width,
                child: Column(
                  children: [
                    const Text('New patient', style: TextStyle(
                      fontSize: 20,
                    ),),
                    TextField(
                      controller: patientName,
                      decoration: InputDecoration(
                        label: Text('Patient\'s name'),
                      ),
                    ),
                    TextField(
                      controller: patientUsername,
                      decoration: const InputDecoration(
                        label: Text('Username'),
                      ),
                    ),
                    TextField(
                      controller: patientPassword,
                      decoration: const InputDecoration(
                        label: Text('Password'),
                      ),
                    ),
                    const SizedBox(height: 20,),
                    ElevatedButton(
                      onPressed: (){
                        if (patientName.text.isEmpty || patientUsername.text.isEmpty || patientPassword.text.isEmpty){
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please complete information!')),
                          );
                        }else {
                          setState(() {
                            listPatient.add(Patient(name: patientName.text));
                            patientName.text='';
                            patientPassword.text = '';
                            patientUsername.text = '';
                          });
                          Navigator.pop(context);
                        }
                      },
                      style: const ButtonStyle(
                          padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30,vertical: 10)),
                          backgroundColor: MaterialStatePropertyAll(Colors.red),
                          foregroundColor: MaterialStatePropertyAll(Colors.white)
                      ),
                      child: const Text('Add new'),
                    ),
                  ],
                ),
                          ),
              ));
        },
        child: Icon(Icons.add_rounded,color: Colors.white,),
        backgroundColor: Color(0xff9bc7d5),
        shape: CircleBorder(),
      ),
      backgroundColor: Color(0xffeeeeee),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 30.0,
                    backgroundImage: AssetImage('images/avatar.png'), // Đặt hình ảnh
                  ),
                  SizedBox(width: 10,),
                  Text('Username',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 24
                    ),)
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 35,))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              mySwitch = true;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: mySwitch?Colors.grey:Colors.transparent
                            ),
                            child: Text('list patients',textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(

                          onTap: (){
                            mySwitch = false;
                            setState(() {
                          });},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: !mySwitch?Colors.grey:Colors.transparent
                            ),
                            child: Text('list devices',textAlign: TextAlign.center,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                mySwitch?
                SizedBox(
                  height: MediaQuery.sizeOf(context).height - 250,
                  child: SingleChildScrollView(
                    child: Column(children:
                      listPatient.map((e) => PatientCard(
                          name: e.name,
                          age:(e.dateOfBirth==null)?null:DateTime.now().year - e.dateOfBirth!.year,
                          diagnose: e.diagnose,
                        ontap: (){
                            Navigator.push(context,
                            MaterialPageRoute(builder: (context)=>PatientMornitoringScreen(patient:e)));
                        },
                      )
                      ).toList(),
                    ),
                  ),
                )
                :DeviceCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
