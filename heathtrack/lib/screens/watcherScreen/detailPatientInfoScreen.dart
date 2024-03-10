import 'package:flutter/material.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/profile.dart';
import 'package:heathtrack/services/profileService.dart';
import 'package:intl/intl.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../objects/patient.dart';
import '../../widgets/InforBar.dart';

class DetailPatientInfoScreen extends StatefulWidget {
  DetailPatientInfoScreen({super.key, required this.patient});
  Patient patient;

  @override
  State<DetailPatientInfoScreen> createState() =>
      _DetailPatientInfoScreenState();
}

class _DetailPatientInfoScreenState extends State<DetailPatientInfoScreen> {
  final ProfileService profileService = ProfileService();
  var profileDataList = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchProfileData();
  }

  fetchProfileData() async {
    try {
      profileDataList = await profileService.fetchProfileData(
          context: context, userId: widget.patient.id);
      if (mounted) {
        setState(() {});
      }
      // setState(() {});
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    String formatDate(String timeString) {
      String time; //2024-03-08T04:38:34.124Z
      time = DateFormat('dd/MM/yyyy').format(DateTime.parse(timeString));
      return time;
    }

    return profileDataList.isEmpty
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text('${widget.patient.name}\'s information'),
            ),
            body: SingleChildScrollView(
              child: Container(
                color: const Color(0xfff7f7f7),
                padding: const EdgeInsets.only(top: 20),
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
                          ],
                        ),
                      ),
                    ),
                    Text(
                      shortenName(widget.patient.name),
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
                        widget.patient.name,
                        onTouch: () {},
                        canEdit: false,
                      ),
                      Infor(
                        'Gender',
                        "${profileDataList[0].gender}",
                        canEdit: false,
                        onTouch: () {},
                      ),
                      Infor(
                        'Date of Birth',
                        (profileDataList[0].dateOfBirth == null)
                            ? 'No information'
                            : "${formatDate(profileDataList[0].dateOfBirth)}",
                        onTouch: () {},
                        canEdit: false,
                      ),
                    ]),
                    InforBar('Communications', [
                      Infor(
                        'Phone number',
                        "${profileDataList[0].phoneNumber}",
                        canEdit: false,
                        onTouch: () {},
                      ),
                      Infor(
                        'Email',
                        "${widget.patient.email}",
                        canEdit: false,
                        onTouch: () {},
                      ),
                    ]),
                    InforBar('Body indicators', [
                      Infor('Blood Type', '${profileDataList[0].bloodType}',
                          canEdit: false, onTouch: () {}),
                      Infor('Height (cm)', '${profileDataList[0].height}',
                          canEdit: false, onTouch: () {}),
                      Infor('Weight (kg)', '${profileDataList[0].weight}',
                          canEdit: false, onTouch: () {}),
                      Infor(
                        'BMI',
                        (profileDataList[0].weight != null &&
                                profileDataList[0].height != null)
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
          );
  }
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
