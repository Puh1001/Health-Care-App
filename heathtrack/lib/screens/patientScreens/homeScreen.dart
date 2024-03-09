import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/patientScreens/patientSettingScreen.dart';
import 'package:heathtrack/screens/patientScreens/sosScreen.dart';
import 'package:heathtrack/widgets/healthIndicators.dart';
import 'package:provider/provider.dart';
import '../../constants/utils.dart';
import '../../services/patientServices.dart';
import '../../widgets/HorizontalBar.dart';
import '../../widgets/Summary.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final PatientServices patientServices = PatientServices();

  var healthDataList = [];

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchHealthData();
  }

  fetchHealthData() async {
    try {
      healthDataList = await patientServices.fetchHeathData(context);
      setState(() {});
    } catch (err) {
      if (this.mounted) {
        setState(() {
          print(err);
          showSnackBar(context, err.toString());
        });
      }
    }
  }

  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (BuildContext context, patient, child) {
        return healthDataList.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: const Color(0xfff7f7f7),
                body: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contexxt) =>
                                                PatientSettingScreen()));
                                  },
                                  icon: const Icon(
                                    Icons.settings,
                                    size: 30,
                                  )),
                              const SizedBox(width: 5)
                            ]),
                        GestureDetector(onTap: () {}, child: SummaryWG()),
                        Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.only(top: 20),
                          child: HealthIndicators(
                              heathData:
                                  healthDataList[healthDataList.length - 1]
                              // patient.user.healthDataList.isEmpty?
                              // HeathData(heartRate: 0, spb: 0, dbp: 0, oxygen: 0, temperature: 0, glucose: 0, step: 0, timestamp: DateTime.now().toString(), userId: '')
                              //     :patient.user.healthDataList[patient.user.healthDataList.length -1],
                              ),
                        ),
                        HorizontalBar(
                          const Icon(
                            Icons.emergency,
                            color: Colors.red,
                          ),
                          'Emergency',
                          ontap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SosScreen()));
                          },
                        ),
                        HorizontalBar(
                          const Icon(
                            Icons.apple,
                            color: Colors.greenAccent,
                          ),
                          'Nutritions',
                          ontap: () {},
                        ),
                        HorizontalBar(
                          const Icon(
                            Icons.spa_outlined,
                            color: Colors.blueAccent,
                          ),
                          'BMI',
                          ontap: () {},
                        ),
                        const SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
