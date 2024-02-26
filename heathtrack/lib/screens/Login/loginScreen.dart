import 'package:flutter/material.dart';
import 'package:heathtrack/screens/patientScreens/patientControlScreen.dart';
import 'package:heathtrack/screens/watcherScreen/watcherHomeScreen.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> PatientControlScreen()));
              },
                  child: Text('I\'m Patient')),
              const SizedBox(height: 20,),
              ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> WatcherHomeScreen()));
              },
                  child: Text('I\'m Watcher'))
            ],
          ),
        ),
      );
  }
}
