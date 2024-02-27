import 'package:flutter/material.dart';
import 'package:heathtrack/screens/Login/login_view.dart';
import 'package:heathtrack/screens/patientScreens/homeScreen.dart';
import 'package:heathtrack/screens/patientScreens/patientControlScreen.dart';
import 'package:heathtrack/screens/patientScreens/profileScreen.dart';
import 'package:heathtrack/screens/patientScreens/sosScreen.dart';
import 'package:heathtrack/screens/watcherScreen/watcherHomeScreen.dart';
import 'package:provider/provider.dart';
import 'objects/patient.dart';

main() => runApp(const HeathTrackApp());

class HeathTrackApp extends StatefulWidget {
  const HeathTrackApp({super.key});
  @override
  State<HeathTrackApp> createState() => _HeathTrackAppState();
}

class _HeathTrackAppState extends State<HeathTrackApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => Patient(
            name: "Khanh", sex: 'female', dateOfBirth: DateTime(2000, 4, 3)),
        child:
            MaterialApp(debugShowCheckedModeBanner: false, home: LoginView()));
  }
}
