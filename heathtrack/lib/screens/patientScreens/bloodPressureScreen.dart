import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/screens/patientScreens/checkBloodPressure.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:heathtrack/widgets/chart.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../k_services/getEachHealthData.dart';
import '../../widgets/diagnoseBar.dart';

class BloodPressureScreen extends StatefulWidget {
  var patientId;
  BloodPressureScreen({super.key, required this.patientId});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  List<Data2> listData = [];

  GetEachHealthData getEachHealthData = GetEachHealthData();

  final WatcherService watcherService = WatcherService();

  var healthDataList;

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchHealthData();
  }

  fetchHealthData() async {
    try {
      print(widget.patientId);
      healthDataList = await watcherService.fetchHeathDataInWatcher(
          context, widget.patientId);
      listData = getEachHealthData.getListBloodPressure(healthDataList);
      if (mounted) {
        setState(() {});
      }
    } catch (err) {
      print(err);
      showSnackBar(context, err.toString());
    }
  }

  String? currentValue;
  double maxSystolic = double.negativeInfinity;
  double minSystolic = double.infinity;
  double maxDiastolic = double.negativeInfinity;
  double minDiastolic = double.infinity;
  @override
  Widget build(BuildContext context) {
    currentValue = listData.isEmpty
        ? ""
        : '${listData[listData.length - 1].val1.toInt()}/${listData[listData.length - 1].val2.toInt()}';
    double maxSys = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.val1 > next.val1 ? curr : next)
            .val1;
    double minSys = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.val1 < next.val1 ? curr : next)
            .val2;
    double maxDia = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.val2 > next.val2 ? curr : next)
            .val1;
    double minDia = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.val2 < next.val2 ? curr : next)
            .val2;
    return healthDataList == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Blood pressure'),
            ),
            backgroundColor: const Color(0xffF0E6E0),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20),
                            bottomLeft: Radius.circular(20))),
                    child: Column(children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Icon(
                              FontAwesomeIcons.droplet,
                              color: Colors.red,
                              size: 55,
                            ),
                          ),
                          Text(
                            "$currentValue mmHg",
                            style: const TextStyle(
                                fontSize: 40,
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Chart2(listData: listData),
                    ]),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DiagnoseBar(
                    diagnose: DiagnosisEngine.diagnoseBloodPressureIssue(
                        listData[listData.length - 1].val1.toInt(),
                        listData[listData.length - 1].val2.toInt()),
                  ),
                  DataBar(
                    name: 'Current Blood pressure',
                    value: '$currentValue',
                  ),
                  DataBar(
                    name: 'Max systolic',
                    value: '$maxSys',
                  ),
                  DataBar(
                    name: 'Min systolic',
                    value: '$minSys',
                  ),
                  DataBar(
                    name: 'Max diastolic',
                    value: '$maxDia',
                  ),
                  DataBar(
                    name: 'Min diastolic',
                    value: '$minDia',
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CheckBloodPressure()));
                    },
                    style: const ButtonStyle(
                        foregroundColor: MaterialStatePropertyAll(Colors.white),
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      child: Text('Check',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
