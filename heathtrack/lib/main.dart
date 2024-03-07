import 'package:flutter/material.dart';
import 'package:heathtrack/objects/watcher.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/router.dart';
import 'package:heathtrack/screens/Login/login_view.dart';
import 'package:heathtrack/screens/patientScreens/patientControlScreen.dart';
import 'package:heathtrack/screens/watcherScreen/watcherControlScreen.dart';
import 'package:heathtrack/services/authService.dart';
import 'package:provider/provider.dart';
import 'objects/patient.dart';

main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => UserProvider(),
      ),
    ], child: const HeathTrackApp()));

class HeathTrackApp extends StatefulWidget {
  const HeathTrackApp({super.key});

  @override
  State<HeathTrackApp> createState() => _HeathTrackAppState();
}

class _HeathTrackAppState extends State<HeathTrackApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => UserProvider())
          // ChangeNotifierProvider(create: (context) => Patient(
          //   name: "Khanh",
          //   sex: 'female',
          //   dateOfBirth: DateTime(2000, 4, 3),
          //   id: '',
          // ),),
          // ChangeNotifierProvider(create: (context) => Watcher(
          //   name: "I Am Watcher",
          //   gender: 'female',
          //   dateOfBirth: DateTime(1999, 9, 9),
          // ),),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) => generateRoute(settings),
            home: Provider.of<UserProvider>(context).user.token.isNotEmpty
                ? Provider.of<UserProvider>(context).user.type == 'watcher'
                    ? const WatcherControlScreen()
                    : const PatientControlScreen()
                : const LoginView()));
  }
}
