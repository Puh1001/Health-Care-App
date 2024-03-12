import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heathtrack/k_services/diagnoseEngine.dart';
import 'package:heathtrack/k_services/getEachHealthData.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/watcherScreen/detailPatientInfoScreen.dart';
import 'package:heathtrack/services/localNotifications.dart';
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
  final WatcherService watcherService = WatcherService();

  var healthDataList;

  Timer? _pollingTimer;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchHealthData();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    super.dispose();
  }

  fetchHealthData() async {
    try {
      healthDataList = await watcherService.fetchHeathDataInWatcher(
          context, widget.patient.id);
      processHealthData(); // Cập nhật giao diện với dữ liệu ban đầu

      // Bắt đầu bộ đếm thời gian long polling
      _pollingTimer = Timer.periodic(const Duration(seconds: 5), (_) async {
        try {
          final updatedHealthData = await watcherService
              .fetchHeathDataInWatcher(context, widget.patient.id);
          if (updatedHealthData != healthDataList) {
            // Cập nhật dữ liệu và giao diện nếu nhận được dữ liệu mới
            healthDataList = updatedHealthData;
            processHealthData();
          }
        } catch (err) {
          showSnackBar(context, err.toString());
        }
      });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  processHealthData() {
    if (mounted) {
      listHeartData = getEachHealthData.getListHeartRate(healthDataList);
      listBloodData = getEachHealthData.getListBloodPressure(healthDataList);
      listOxyData = getEachHealthData.getListOxygen(healthDataList);
      listTempData = getEachHealthData.getListTemperature(healthDataList);
      listGlucoseData = getEachHealthData.getListGlucose(healthDataList);

      setState(() {});
    }
  }

  GetEachHealthData getEachHealthData = GetEachHealthData();

  List<Data> listHeartData = [];
  List<Data2> listBloodData = [];
  List<Data> listOxyData = [];
  List<Data> listTempData = [];
  List<Data> listGlucoseData = [];

  String statusDiagnose() {
    String diagnose;
    int heartRate = (listHeartData.isEmpty
            ? 0
            : listHeartData[listHeartData.length - 1].value)!
        .toInt();
    List<int> bloodStatus = listBloodData.isEmpty
        ? [0, 0]
        : [
            listBloodData[listBloodData.length - 1].val1.toInt(),
            listBloodData[listBloodData.length - 1].val2.toInt(),
          ];
    double oxyStatus =
        (listOxyData.isEmpty ? 0 : listOxyData[listOxyData.length - 1].value)!;
    double tempStatus = (listTempData.isEmpty
        ? 0
        : listTempData[listTempData.length - 1].value)!;
    double glucoseStatus = (listGlucoseData.isEmpty
        ? 0
        : listGlucoseData[listGlucoseData.length - 1].value)!;
    diagnose = DiagnosisEngine.diagnoseHealth(
        tempStatus, bloodStatus, heartRate, glucoseStatus, oxyStatus);
    if (diagnose.isNotEmpty) {
      localNotifications.showNotification(
          title: "Dangerous !!",
          body: diagnose,
          payload: "Something is not right 😔🤔");
    } else {
      diagnose += "Everything Good !!";
    }
    return diagnose;
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
                            height: 20,
                          ),
                          Wrap(
                            children: [
                              const Icon(
                                Icons.check_circle_outline,
                                color: Colors.white,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Wrap(
                                children: [
                                  Text(
                                    'Diagnose:',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                      width:
                                          5), // Khoảng trắng giữa "Diagnose:" và kết quả
                                  Text(
                                    '${statusDiagnose()}',
                                    style: const TextStyle(
                                      fontSize: 15,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
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
                  healthDataList == null
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
