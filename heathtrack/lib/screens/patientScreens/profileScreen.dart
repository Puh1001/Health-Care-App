import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/patientScreens/editProfileScreen.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../widgets/InforBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File image = File('images/avatar.png');

  // void selectImage() async {
  //   var res = await pickImage();
  //   setState() {
  //     image = res!;
  //   }
  // }

  final WatcherService watcherService = WatcherService();

  // void addPatientProfile(){
  //   watcherService.addPatientProfile(context: context, name: name, dateOfBirth: dateOfBirth, gender: gender, phoneNumber: phoneNumber, email: email, height: height, weight: weight, bmi: bmi, image: image)
  // }
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (BuildContext context, patient, child) {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              color: const Color(0xfff7f7f7),
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 80,
                    child: CircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.white,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: ClipOval(
                              child: Image.file(
                                image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: CircleAvatar(
                              backgroundColor: Colors.black.withOpacity(0.5),
                              child: IconButton(
                                onPressed: () async {
                                  File? pickedImage = await pickImage();
                                  if (pickedImage != null) {
                                    setState(() {
                                      image = pickedImage;
                                    });
                                  }
                                },
                                icon: const Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                ),
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    shortenName(patient.user.name),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InforBar('Main Information', [
                    Infor(
                      'Name',
                      patient.user.name,
                      // onTouch: (value) {
                      //   patient.updateName(value);
                      // },
                      onTouch: (){},
                      canEdit: false,
                    ),

                    Infor(
                      'Gender',
                      "${patient.user.gender}",
                      canEdit: false, onTouch: (){},
                      // onTouch: (value) {
                      //   patient.updateSex(value);
                      // },
                    ),
                    Infor(
                      'Date of Birth',
                      (patient.user.dateOfBirth == null)
                          ? 'No information'
                          : DateFormat('dd/MM/yyyy').format(patient.user.dateOfBirth!),
                      onTouch: () async{
                          final DateTime? dateTime = await showDatePicker(
                              context: context,
                              initialDate: patient.user.dateOfBirth ?? DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2025));

                          if (dateTime != null) {
                            setState(() {
                              patient.user.updateDateOfBirth(dateTime);
                            });
                          }
                        },
                    ),
                  ]),
                  InforBar('Communications', [
                    Infor(
                      'Phone number',
                      "${patient.user.phoneNumber}",
                      onTouch: () {
                        showDialog(context: context,
                            builder: (BuildContext){
                              TextEditingController contentController = TextEditingController();
                              contentController.text = patient.user.phoneNumber==null?'':'${patient.user.phoneNumber}';
                              return AlertDialog(
                                title: const Text("Edit phone number"),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: contentController,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        //patient.updatePhoneNumber(contentController.text);
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK")),
                                  TextButton(
                                      onPressed: (){Navigator.of(context).pop();},
                                      child: const Text("Cancel")),
                                ],
                              );
                            });
                      },
                    ),
                    Infor(
                      'Email',
                      "${patient.user.email}",
                      // onTouch: (value) {
                      //   patient.updateEmail(value);
                      // },
                      canEdit: false, onTouch: (){},
                    ),
                  ]),
                  InforBar('Body indicators', [
                    Infor(
                      'Height (cm)',
                      '${patient.user.height}',
                      onTouch: () {
                        showDialog(context: context,
                            builder: (BuildContext){
                              TextEditingController contentController = TextEditingController();
                              contentController.text = patient.user.height==null?'':'${patient.user.height}';
                              return AlertDialog(
                                title: const Text("Edit height"),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: contentController,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        //patient.updateHeight(double.parse(contentController.text));
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("OK")),
                                  TextButton(
                                      onPressed: (){Navigator.of(context).pop();},
                                      child: const Text("Cancel")),
                                ],
                              );
                            });
                      },
                    ),
                    Infor(
                      'Weight (kg)',
                      '${patient.user.weight}',
                      onTouch: () {
                        showDialog(context: context,
                            builder: (BuildContext){
                              TextEditingController contentController = TextEditingController();
                              contentController.text = patient.user.weight==null?'':'${patient.user.weight}';
                              return AlertDialog(
                                title: const Text("Edit weight"),
                                content: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: contentController,
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: (){
                                        //patient.updateWeight(double.parse(contentController.text));
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("OK")),
                                  TextButton(
                                      onPressed: (){Navigator.of(context).pop();},
                                      child: Text("Cancel")),
                                ],
                              );
                            });
                      },
                    ),
                    Infor(
                      'BMI',
                        (patient.user.weight != null && patient.user.height != null)
                            ? '${DiagnosisEngine.calculateBMI(patient.user.weight!, patient.user.height!)} (${DiagnosisEngine.diagnoseBMI(DiagnosisEngine.calculateBMI(patient.user.weight!, patient.user.height!))})'
                            : 'no information',
                      canEdit: false, onTouch: (){},
                    )
                  ])
                ],
              ),
            ),
          ),
          Container(
            height: 85,
            decoration: const BoxDecoration(
              color: Color(0xfff7f7f7),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30)),
            ),
          ),
        ],
      );
    });
  }

  String shortenName(String fullName) {
    String shortenName;
    fullName = fullName.trim();
    if (fullName.contains(" ")) {
      String startString = fullName.substring(0, fullName.indexOf(' '));
      String endString = fullName.substring(fullName.lastIndexOf(' ') + 1);
      shortenName = "$startString $endString";
    } else {
      shortenName = fullName;
    }
    return shortenName;
  }
}
