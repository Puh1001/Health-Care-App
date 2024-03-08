import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/watcherScreen/detailPatientInfoScreen.dart';
import 'package:heathtrack/widgets/healthIndicators.dart';
import 'package:provider/provider.dart';

import '../../constants/utils.dart';
import '../../models/heathData.dart';
import '../../objects/patient.dart';
import '../../services/watcherService.dart';

class PatientMornitoringScreen extends StatefulWidget {
  Patient patient;
  PatientMornitoringScreen({super.key, required this.patient});

  @override
  State<PatientMornitoringScreen> createState() =>
      _PatientMornitoringScreenState();
}

class _PatientMornitoringScreenState extends State<PatientMornitoringScreen> {
  //List<Data> listData = [];
  final WatcherService patientServices = WatcherService();
  var healthDataList = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchHealthData();
  }

  fetchHealthData() async {
    try {
      healthDataList = await patientServices.fetchHeathDataInWatcher(
          context, widget.patient.id);
      setState(() {});
    } catch (err) {
      print(err);
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, user, child) {
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
                child: Column(children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailPatientInfoScreen(
                                  patient: widget.patient)));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              offset: const Offset(0, 4),
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1))
                        ],
                        borderRadius: BorderRadius.circular(20),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFFBEA2FF),
                            Color(0xFFF5CCCC),
                            Color(0xFF9EFFF4),
                          ],
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: AspectRatio(
                                    aspectRatio: 1 / 1.2,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                              image: AssetImage(
                                                widget.patient.gender ==
                                                        'female'
                                                    ? 'images/womanAvatar.png'
                                                    : 'images/manAvatar.png',
                                              ),
                                              fit: BoxFit.fitHeight)),
                                    ),
                                  )),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.patient.name,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'ID: ${widget.patient.id}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        (widget.patient.dateOfBirth == null)
                                            ? '${user.lang.age}: ${user.lang.noInformation}'
                                            : '${user.lang.age}:  ${DateTime.now().year - widget.patient.dateOfBirth!.year}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                      Text(
                                        '${user.lang.phoneNumber}:${widget.patient.phoneNumber ?? user.lang.noInformation}',
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${user.lang.diagnose}: ${widget.patient.diagnose}',
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  healthDataList.isEmpty
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : HealthIndicators(
                          patientId: widget.patient.id,
                          heathData: healthDataList.isEmpty
                              ? HeathData(
                                  heartRate: 0,
                                  spb: 0,
                                  dbp: 0,
                                  oxygen: 0,
                                  temperature: 0,
                                  glucose: 0,
                                  step: 0,
                                  timestamp: '0',
                                  userId: 'userId')
                              : healthDataList[healthDataList.length - 1]),
                  const SizedBox(
                    height: 30,
                  ),
                ]),
              )));
    });
  }
}
