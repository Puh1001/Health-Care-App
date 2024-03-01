import 'package:flutter/material.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/router.dart';
import 'package:heathtrack/screens/Login/login_view.dart';
import 'package:heathtrack/screens/patientScreens/patientControlScreen.dart';
import 'package:heathtrack/screens/watcherScreen/watcherControlScreen.dart';
import 'package:heathtrack/services/authService.dart';
import 'package:provider/provider.dart';
import 'objects/patient.dart';
import 'screens/patientScreens/ProfileScreen.dart';


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
    return ChangeNotifierProvider(
        create: (context) => Patient(
              name: "Khanh",
              sex: 'female',
              dateOfBirth: DateTime(2000, 4, 3),
              id: '',
            ),
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            onGenerateRoute: (settings) => generateRoute(settings),
            // home: const LoginView()));
            home: ProfileScreen(),
            // home: Provider.of<UserProvider>(context).user.token.isNotEmpty
            //     ? Provider.of<UserProvider>(context).user.type == 'watcher'
            //         ? const PatientControlScreen()
            //         : const PatientControlScreen()
            //     : const LoginView()
        )
    );
  }
}
