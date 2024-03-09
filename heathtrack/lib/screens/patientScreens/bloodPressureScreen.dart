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
  List<Data> listData = [];

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
      listData = getEachHealthData.getListHeartRate(healthDataList);
      setState(() {});
    } catch (err) {
      print(err);
      showSnackBar(context, err.toString());
    }
  }

  double? currentValue;
  double? maxValue;
  double? minValue;
  double? average;
  @override
  Widget build(BuildContext context) {
    currentValue = listData.isEmpty ? 0 : listData[listData.length - 1].value;
    maxValue = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.value > next.value ? curr : next)
            .value;
    minValue = listData.isEmpty
        ? 0
        : listData
            .reduce((curr, next) => curr.value < next.value ? curr : next)
            .value;
    average = listData.isEmpty
        ? 0
        : (listData.map((data) => data.value).reduce((a, b) => a + b) /
            listData.length);
    return Scaffold(
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
                        size: 60,
                      ),
                    ),
                    Text(
                      "$currentValue mmHg",
                      style: const TextStyle(
                          fontSize: 45,
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Chart(listData: listData),
              ]),
            ),

            const SizedBox(
              height: 20,
            ),
            DiagnoseBar(
                diagnose: DiagnosisEngine.diagnoseBloodPressureIssue(80,
                    50)), //<<<-------<<<-----------------------------------------
            DataBar(
              name: 'Current Blood pressure',
              value: '$currentValue',
            ),
            DataBar(
              name: 'Average Blood pressure',
              value: '${(average! * pow(10, 1)).round() / pow(10, 1)}',
            ),
            DataBar(
              name: 'Max Blood pressure',
              value: '$maxValue',
            ),
            DataBar(
              name: 'Min Blood pressure',
              value: '$minValue',
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CheckBloodPressure()));
              },
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.white),
                  backgroundColor: MaterialStatePropertyAll(Colors.red)),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
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
