import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/heathData.dart';
import 'package:heathtrack/services/patientServices.dart';
import 'package:heathtrack/widgets/chart.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
  List<double>? listData;
  final PatientServices patientServices = PatientServices();

  // State variables for data metrics
  double currentValue = 0;
  double maxValue = 0;
  double minValue = 0;
  double average = 0;

  @override
  void initState() {
    super.initState();
    fetchHealthData();
  }

  void fetchHealthData() async {
    try {
      final healthDataList = await patientServices.fetchHeathData(context);
      if (healthDataList != null) {
        // Extract heart rates
        listData = healthDataList.map((data) => data.heartRate).toList();
        calculateMetrics();
        setState(() {});
      } else {
        // Handle the case where health data is not available
        print("No health data found");
      }
    } catch (err) {
      showSnackBar(
          context, err.toString()); // Assuming showErrorSnackBar is defined
    }
  }

  void calculateMetrics() {
    if (listData != null && listData!.isNotEmpty) {
      currentValue = listData![listData!.length - 1];
      maxValue = listData!.reduce(max);
      minValue = listData!.reduce(min);
      average = listData!.reduce((a, b) => a + b) / listData!.length;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Heart rate'),
      ),
      backgroundColor: const Color(0xffD2F2DB),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                const SizedBox(height: 20),
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
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                // Chart(listData: listData, max: maxValue),
              ],
            ),
          ),
          const SizedBox(height: 20),
          DataBar(
            name: 'Current Heart rate',
            value: '$currentValue',
          ),
          DataBar(
            name: 'Average Heart rate',
            value: '${(average * pow(10, 1)).round() / pow(10, 1)}',
          ),
          DataBar(
            name: 'Max Heart rate',
            value: '$maxValue',
          ),
          DataBar(
            name: 'Min Heart rate',
            value: '$minValue',
          ),
        ],
      ),
    );
  }
}
