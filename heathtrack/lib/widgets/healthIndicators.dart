import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/heathData.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/services/watcherService.dart';
import 'package:provider/provider.dart';
import '../objects/patient.dart';
import '../screens/patientScreens/bloodPressureScreen.dart';
import '../screens/patientScreens/glucoseLevelScreen.dart';
import '../screens/patientScreens/heartRateScreen.dart';
import '../screens/patientScreens/oxygenScreen.dart';
import '../screens/patientScreens/temperatureScreen.dart';
import 'Metrics.dart';

class HealthIndicators extends StatefulWidget {
  HealthIndicators({super.key, required this.heathData});
  HeathData heathData;

  @override
  State<HealthIndicators> createState() => _HealthIndicatorsState();
}

class _HealthIndicatorsState extends State<HealthIndicators> {
  var heartRateStatus = 0;

  var bloodPressureStatus = 0;

  var glucoseLevelStatus = 0;

  var oxygenStatus = 0;

  var temperatureStatus = 0;

  List<Patient> listPatient = [];
  final WatcherService watcherService = WatcherService();
  var listPatientInW = [];
  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    fetchAddressPatient();
  }

  fetchAddressPatient() async {
    try {
      listPatientInW = await watcherService.fetchAddressPatient(
        context: context,
        watcherId: Provider.of<UserProvider>(context, listen: false).user.id,
      );
      setState(() {});
    } catch (err) {
      print(err);
      showSnackBar(context, err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    // heathData.updateStatus();
    // heartRateStatus = heathData.heartRateStatus;
    // bloodPressureStatus = heathData.bloodPressureStatus;
    // glucoseLevelStatus = heathData.bloodGlucoseLevelStatus;
    // oxygenStatus = heathData.oxygenSaturationStatus;
    // temperatureStatus = heathData.bodyTemperatureStatus;
    listPatient.clear();
    for (var i in listPatientInW) {
      Patient patient = Patient(
          id: '',
          name: '',
          email: '',
          password: '',
          familyCode: '',
          address: '',
          type: '',
          token: '',
          watcherId: '');
      patient.getDataFromPatientInWatcher(i);
      listPatient.add(patient);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          Provider.of<UserProvider>(context).lang.healthIndicator,
          style: TextStyle(
              fontWeight: FontWeight.w500, color: Colors.grey, fontSize: 18),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Metrics(
              const Icon(
                FontAwesomeIcons.heartPulse,
                color: Colors.white,
                size: 35,
              ),
              Provider.of<UserProvider>(context).lang.heartRate,
              "${widget.heathData.heartRate}",
              'bpm',
              problem: heartRateStatus,
              background: const Color(0xffD4F4DC),
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HeartRateScreen()));
              },
            ),
            const SizedBox(
              width: 15,
            ),
            Metrics(
              const Icon(
                FontAwesomeIcons.droplet,
                color: Colors.white,
                size: 40,
              ),
              "Blood\nPressure",
              "${widget.heathData.spb}/${widget.heathData.dbp}",
              'mmHg',
              problem: bloodPressureStatus,
              background: Color(0xffF7CECD),
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BloodPressureScreen()));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Metrics(
              const Icon(
                FontAwesomeIcons.o,
                color: Colors.white,
                size: 40,
              ),
              "Oxygen\nSaturation",
              "${widget.heathData.oxygen}",
              '%',
              problem: oxygenStatus,
              background: Color(0xffD4E3F4),
              ontap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => OxygenScreen()));
              },
            ),
            const SizedBox(
              width: 15,
            ),
            Metrics(
              const Icon(
                FontAwesomeIcons.temperatureFull,
                color: Colors.white,
                size: 40,
              ) as Icon,
              "Body\nTemperature",
              "${widget.heathData.temperature}",
              '°C',
              problem: temperatureStatus,
              background: Color(0xffF4EDD4),
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TemperatureScreen()));
              },
            ),
          ],
        ),
        const SizedBox(
          height: 15,
        ),
        Row(
          children: [
            Metrics(
              const Icon(
                FontAwesomeIcons.g,
                color: Colors.white,
                size: 45,
              ),
              "Glucose\nlevel",
              "${widget.heathData.glucose}",
              'mg/DL',
              problem: glucoseLevelStatus,
              background: Color(0xffDAD4F4),
              ontap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GlucoseLevelScreen()));
              },
            ),
            const SizedBox(
              width: 15,
            ),
            Metrics(
              const Icon(
                FontAwesomeIcons.personRunning,
                color: Colors.white,
                size: 50,
              ),
              Provider.of<UserProvider>(context).lang.activity,
              "${widget.heathData.step}", //------------------------------------------need to fix-------------------------------------------------------------
              'steps',
              problem: -1,
              background: const Color(0xffD2D8DE),
              ontap: () {},
            ),
          ],
        ),
      ],
    );
  }
}
