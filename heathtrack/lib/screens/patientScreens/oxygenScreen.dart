import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/k_services/diagnoseEngine.dart';
import 'package:heathtrack/screens/patientScreens/checkOxygen.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:heathtrack/widgets/chart.dart';

import '../../k_services/getEachHealthData.dart';
import '../../widgets/diagnoseBar.dart';

class OxygenScreen extends StatefulWidget {
  var patientId;
  OxygenScreen({super.key, required this.patientId});

  @override
  State<OxygenScreen> createState() => _OxygenScreenState();
}

class _OxygenScreenState extends State<OxygenScreen> {
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
      if (mounted) {
        setState(() {});
      }
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
    return healthDataList == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Oxygen saturation'),
            ),
            backgroundColor: const Color(0xffe0f7fc),
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
                              FontAwesomeIcons.o,
                              color: Colors.blueAccent,
                              size: 60,
                            ),
                          ),
                          Text(
                            "$currentValue %",
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
                      diagnose: DiagnosisEngine.diagnoseOxygenSaturationIssue(
                          currentValue!)),
                  DataBar(
                    name: 'Current oxygen saturation',
                    value: '$currentValue',
                  ),
                  DataBar(
                    name: 'Average oxygen saturation',
                    value: '${(average! * pow(10, 1)).round() / pow(10, 1)}',
                  ),
                  DataBar(
                    name: 'Max oxygen saturation',
                    value: '$maxValue',
                  ),
                  DataBar(
                    name: 'Min oxygen saturation',
                    value: '$minValue',
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckOxygen()));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: Text('Check',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
