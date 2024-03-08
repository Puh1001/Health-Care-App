import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/objects/watcher.dart';
import 'package:heathtrack/screens/patientScreens/checkBloodPressure.dart';
import 'package:heathtrack/services/patientServices.dart';
import 'package:heathtrack/widgets/chart.dart';
import 'package:moment_dart/moment_dart.dart';
import 'package:provider/provider.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../k_services/getEachHealthData.dart';
import '../../objects/patient.dart';
import '../../providers/userProvider.dart';
import '../../services/watcherService.dart';
import '../../widgets/diagnoseBar.dart';
import 'checkHeartRate.dart';

class HeartRateScreen extends StatefulWidget {
  var patientId;
  HeartRateScreen({super.key, required this.patientId});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  GetEachHealthData getEachHealthData = GetEachHealthData();
  //final PatientServices patientServices = PatientServices();
  final WatcherService watcherService = WatcherService();
  var healthDataList ;
  List<Data> listData = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  didChangeDependencies(){
    super.didChangeDependencies();
    fetchHealthData();
  }

   fetchHealthData() async {
    try {
      print(widget.patientId);
       healthDataList = await watcherService.fetchHeathDataInWatcher(context,widget.patientId);
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

    //listData = getEachHealthData.getListHeartRate(healthDataList);
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
    return healthDataList==null?Center(child: CircularProgressIndicator(),): Scaffold(
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
                          FontAwesomeIcons.heartPulse,
                          color: Colors.green,
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
                  Chart(listData: listData,min: 40.0,max: 160.0,),
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
