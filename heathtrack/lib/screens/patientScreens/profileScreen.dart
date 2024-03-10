import 'dart:io';
import 'package:flutter/material.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/patientScreens/editProfileScreen.dart';
import 'package:heathtrack/services/profileService.dart';
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
  List<File> image = [];
  final ProfileService profileService = ProfileService();
  var profileDataList = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchProfileData();
  }

  Future fetchProfileData() async {
    try {
      profileDataList = await profileService.fetchProfileData(
          context: context, userId: Provider.of<UserProvider>(context).user.id);
      setState(() {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  void selectImage() async {
    var res = await pickImage();
    setState(() {
      image = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(String timeString) {
      String time; //2024-03-08T04:38:34.124Z
      time = DateFormat('dd/MM/yyyy').format(DateTime.parse(timeString));
      return time;
    }

    return Consumer<UserProvider>(
        builder: (BuildContext context, patient, child) {
      return profileDataList.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
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
                                    child: Image.network(
                                      profileDataList[0].image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: IconButton(
                                    onPressed: () async {
                                      selectImage();
                                    },
                                    icon: const Icon(
                                      Icons.camera_alt,
                                      size: 25,
                                    ),
                                    color: Colors.blueAccent,
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
                            onTouch: () {},
                            canEdit: false,
                          ),
                          Infor(
                            'Gender',
                            "${profileDataList[0].gender}",
                            canEdit: false, onTouch: () {},
                            // onTouch: (value) {
                            //   patient.updateSex(value);
                            // },
                          ),
                          Infor(
                            'Date of Birth',
                            (DateTime.parse(profileDataList[0].dateOfBirth) ==
                                    null)
                                ? 'No information'
                                : DateFormat('dd/MM/yyyy').format(
                                    DateTime.parse(
                                        profileDataList[0].dateOfBirth)!),
                            onTouch: () async {
                              final DateTime? dateTime = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.parse(
                                          profileDataList[0].dateOfBirth) ??
                                      DateTime.now(),
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
                            "${profileDataList[0].phoneNumber}",
                            onTouch: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext) {
                                    TextEditingController contentController =
                                        TextEditingController();
                                    contentController.text = patient
                                                .user.phoneNumber ==
                                            null
                                        ? ''
                                        : '${profileDataList[0].phoneNumber}';
                                    return AlertDialog(
                                      title: const Text("Edit phone number"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: contentController,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              //patient.updatePhoneNumber(contentController.text);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
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
                            canEdit: false, onTouch: () {},
                          ),
                        ]),
                        InforBar('Body indicators', [
                          Infor(
                            'Blood Type',
                            '${profileDataList[0].bloodType}',
                            onTouch: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext) {
                                    TextEditingController contentController =
                                        TextEditingController();
                                    contentController.text =
                                        profileDataList[0].bloodType == null
                                            ? ''
                                            : '${profileDataList[0].bloodType}';
                                    return AlertDialog(
                                      title: const Text("Edit Blood Type"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: contentController,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              //patient.updateHeight(double.parse(contentController.text));
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel")),
                                      ],
                                    );
                                  });
                            },
                          ),
                          Infor(
                            'Height (cm)',
                            '${profileDataList[0].height}',
                            onTouch: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext) {
                                    TextEditingController contentController =
                                        TextEditingController();
                                    contentController.text =
                                        profileDataList[0].height == null
                                            ? ''
                                            : '${profileDataList[0].height}';
                                    return AlertDialog(
                                      title: const Text("Edit height"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: contentController,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              //patient.updateHeight(double.parse(contentController.text));
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("OK")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text("Cancel")),
                                      ],
                                    );
                                  });
                            },
                          ),
                          Infor(
                            'Weight (kg)',
                            '${profileDataList[0].weight}',
                            onTouch: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext) {
                                    TextEditingController contentController =
                                        TextEditingController();
                                    contentController.text =
                                        profileDataList[0].weight == null
                                            ? ''
                                            : '${profileDataList[0].weight}';
                                    return AlertDialog(
                                      title: const Text("Edit weight"),
                                      content: TextField(
                                        keyboardType: TextInputType.number,
                                        controller: contentController,
                                      ),
                                      actions: [
                                        TextButton(
                                            onPressed: () {
                                              //patient.updateWeight(double.parse(contentController.text));
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("OK")),
                                        TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: Text("Cancel")),
                                      ],
                                    );
                                  });
                            },
                          ),
                          Infor(
                            'BMI',
                            (patient.user.weight != null &&
                                    patient.user.height != null)
                                ? '${DiagnosisEngine.calculateBMI(profileDataList[0].weight!, profileDataList[0].height!)} (${DiagnosisEngine.diagnoseBMI(DiagnosisEngine.calculateBMI(profileDataList[0].weight!, profileDataList[0].height!))})'
                                : 'no information',
                            canEdit: false,
                            onTouch: () {},
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
