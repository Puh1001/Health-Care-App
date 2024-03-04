import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/screens/patientScreens/editProfileScreen.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/InforBar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File image = File('images/avatar.png');

  final WatcherService watcherService = WatcherService();

  // void addPatientProfile(){
  //   watcherService.addPatientProfile(context: context, name: name, dateOfBirth: dateOfBirth, gender: gender, phoneNumber: phoneNumber, email: email, height: height, weight: weight, bmi: bmi, image: image)
  // }
  @override
  Widget build(BuildContext context) {
    return Consumer<Patient>(builder: (BuildContext context, patient, child) {
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
                                onPressed: () {
                                  changeImage();
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
                    shortenName(patient.name),
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
                      patient.name,
                      onTouch: (value) {
                        patient.updateName(value);
                      },
                    ),
                    Infor(
                      'Date of Birth',
                      (patient.dateOfBirth == null)
                          ? 'No information'
                          : DateFormat('dd/MM/yyyy')
                              .format(patient.dateOfBirth!),
                      onTouch: (value) {
                        patient.updateDateOfBirth(value);
                      },
                    ),
                    Infor(
                      'Gender',
                      "${patient.sex}",
                      onTouch: (value) {
                        patient.updateSex(value);
                      },
                    )
                  ]),
                  InforBar('Group Name', [
                    Infor(
                      'Phone number',
                      "${patient.phoneNumber}",
                      onTouch: (value) {
                        patient.updatePhoneNumber(value);
                      },
                    ),
                    Infor(
                      'Email',
                      "${patient.email}",
                      onTouch: (value) {
                        patient.updateEmail(value);
                      },
                    ),
                  ]),
                  InforBar('Body indicators', [
                    Infor(
                      'Height',
                      '${patient.height} cm',
                      onTouch: (value) {
                        patient.updateHeight(double.parse(value));
                      },
                    ),
                    Infor(
                      'Weight',
                      '${patient.weight} kg',
                      onTouch: (value) {
                        patient.updateWeight(double.parse(value));
                      },
                    ),
                    Infor(
                      'BMI',
                      '',
                      onTouch: () {},
                      canEdit: false,
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
          // Positioned(
          //     top: 50,
          //     right: 20,
          //     child: TextButton(
          //       style: ButtonStyle(
          //           backgroundColor: MaterialStatePropertyAll(
          //               Colors.blueGrey.withOpacity(0.3)),
          //           padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
          //       onPressed: () {
          //         Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //             builder: (context) => EditProfileScreen(),
          //           ),
          //         );
          //       },
          //       child: const Text(
          //         'Edit',
          //         style: TextStyle(fontSize: 18, color: Colors.blueAccent),
          //       ),
          //     )),
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
