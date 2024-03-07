import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/screens/patientScreens/checkBloodPressure.dart';
import 'package:heathtrack/services/patientServices.dart';
import 'package:heathtrack/widgets/chart.dart';
import 'package:moment_dart/moment_dart.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../widgets/diagnoseBar.dart';
import 'checkHeartRate.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  List<Data> listData = [];
  final PatientServices patientServices = PatientServices();

  @override
  initState() {
    super.initState();
    fetchHealthData();
  }

  Future fetchHealthData() async {
    try {
      final healthDataList = await patientServices.fetchHeathData(context);
      if (healthDataList != null) {
        print(healthDataList);
        setState(() {});
      } else {
        print("No health data found");
      }
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  double? currentValue;
  double? maxValue;

  double? minValue;
  double? average;
  @override
  Widget build(BuildContext context) {

    currentValue = (listData.isEmpty ? 0 : listData[listData.length - 1].value);
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
          title: const Text('Heart rate'),
        ),
        backgroundColor: const Color(0xffD2F2DB),
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
                          FontAwesomeIcons.g,
                          color: Colors.purpleAccent,
                          size: 60,
                        ),
                      ),
                      Text(
                        "$currentValue bpm",
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
                  diagnose: DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(
                      currentValue!)),
              DataBar(
                name: 'Current Heart rate',
                value: '$currentValue',
              ),
              DataBar(
                name: 'Average Heart rate',
                value: '${(average! * pow(10, 1)).round() / pow(10, 1)}',
              ),
              DataBar(
                name: 'Max Heart rate',
                value: '$maxValue',
              ),
              DataBar(
                name: 'Min Heart rate',
                value: '$minValue',
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CheckHeartRate()));
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                  child: Text('Check',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
              ),
            ],
          ),
        ));
  }
}
