import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/watcherScreen/patientMornitoringScreen.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:heathtrack/widgets/patientCard.dart';
import 'package:provider/provider.dart';

import '../../objects/patient.dart';
import '../../objects/watcher.dart';
import '../../widgets/deviceCard.dart';

class WatcherHomeScreen extends StatefulWidget {
  const WatcherHomeScreen({super.key});

  @override
  State<WatcherHomeScreen> createState() => _WatcherHomeScreenState();
}

class _WatcherHomeScreenState extends State<WatcherHomeScreen> {
  List<Patient> listPatient = [
    Patient(
      name: 'Nguyen Van A',
      dateOfBirth: DateTime(1970, 12, 11),
      gender: "male",
      id: '',
      diagnose: "Good!",
      heartRate: 40,
      bloodGlucoseLevel: 30,
      systolic: 180,
      diastolic: 55,
      bodyTemperature: 38,
      oxygenSaturation: 97, email: '', password: '', familyCode: '', address: '', type: '', token: '',
    ),
    Patient(name: 'Nguyen Van B', gender: "male", id: '', email: '', password: '', familyCode: '', address: '', type: '', token: '',),
    Patient(
        name: 'Nguyen Thi A',
        dateOfBirth: DateTime(1977, 12, 11),
        gender: "female",
        id: '',
      email: '', password: '', familyCode: '', address: '', type: '', token: '',),
    Patient(
        name: 'Nguyen Van D',
        dateOfBirth: DateTime(1955, 12, 11),
        gender: "male",
        id: '',
      email: '', password: '', familyCode: '', address: '', type: '', token: '',),
  ];
  bool mySwitch = true;
  TextEditingController patientName = TextEditingController();
  TextEditingController patientEmail = TextEditingController();
  TextEditingController patientPassword = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final WatcherService watcherService = WatcherService();

  void addPatient() {
    watcherService.addPatient(
      context: context,
      name: patientName.text,
      email: patientEmail.text,
      password: patientPassword.text,
      age: ageController.text,
      type: 'patient',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context,watcher, child){
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                elevation: 5,
                isScrollControlled: true,
                context: context,
                builder: (context) => SingleChildScrollView(
                      child: Container(
                        padding: EdgeInsets.only(
                            top: 20,
                            left: 20,
                            right: 20,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(20),
                              topLeft: Radius.circular(20),
                            )),
                        width: MediaQuery.sizeOf(context).width,
                        child: Column(
                          children: [
                            const Text(
                              'New patient',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextFormField(
                              controller: patientName,
                              decoration: const  InputDecoration(
                                label: Text('Patient\'s name'),
                              ),
                            ),
                            TextFormField(
                              controller: patientEmail,
                              decoration: const InputDecoration(
                                label: Text('Email'),
                              ),
                            ),
                            TextFormField(
                              controller: ageController,
                              decoration: const InputDecoration(
                                label: Text('Age'),
                              ),
                            ),
                            TextFormField(
                              controller: patientPassword,
                              decoration: const InputDecoration(
                                label: Text('Password'),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (patientName.text.isEmpty ||
                                    patientEmail.text.isEmpty ||
                                    patientPassword.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text('Please complete information!')),
                                  );
                                } else {
                                  addPatient();
                                  Navigator.pop(context);
                                }
                              },
                              style: const ButtonStyle(
                                  padding: MaterialStatePropertyAll(
                                      EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10)),
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.red),
                                  foregroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              child: const Text('Add new'),
                            ),
                          ],
                        ),
                      ),
                    ));
          },
          backgroundColor: const Color(0xff9bc7d5),
          shape:const  CircleBorder(),
          child: const  Icon(
            Icons.add_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: watcher.theme.backgroundColor1,
        body: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
             Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 20,
                ),
                const CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                      AssetImage('images/avatar.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  watcher.user.name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24,color: watcher.theme.textColor1)
                ),
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
                        color: watcher.theme.backgroundColor2),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                mySwitch = true;
                              });
                            },
                            child: Container(
                              padding: const  EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: mySwitch
                                      ? const Color(0xFFA5C8EB)
                                      : Colors.transparent),
                              child: const Text(
                                'list patients',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            onTap: () {
                              mySwitch = false;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: !mySwitch
                                      ? const Color(0xFFA5C8EB)
                                      : Colors.transparent),
                              child: const Text(
                                'list devices',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  mySwitch
                      ? SizedBox(
                          height: MediaQuery.sizeOf(context).height - 250,
                          child: SingleChildScrollView(
                            child: Column(
                              children: listPatient
                                  .map((e) => PatientCard(
                                    isWoman: e.gender=='female'?true:false,
                                    name: e.name,
                                    age: (e.dateOfBirth == null)
                                        ? null
                                        : DateTime.now().year -
                                        e.dateOfBirth!.year,
                                    diagnose: e.diagnose??watcher.lang.noInformation,
                                    ontap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PatientMornitoringScreen(patient: e)
                                          )
                                      );
                                    },
                                  ))
                                  .toList(),
                            ),
                          ),
                        )
                      : const DeviceCard()
                ],
              ),
            ),
          ],
        ),
      );}
    );
  }
}
