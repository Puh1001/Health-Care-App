
import 'package:flutter/material.dart';
import 'package:heathtrack/screens/patientScreens/homeScreen.dart';
import 'package:heathtrack/screens/patientScreens/profileScreen.dart';
import 'package:provider/provider.dart';
import 'objects/patient.dart';

main () => runApp(const HeathTrackApp());

class HeathTrackApp extends StatefulWidget {
  const HeathTrackApp({super.key});
  @override
  State<HeathTrackApp> createState() => _HeathTrackAppState();
}

class _HeathTrackAppState extends State<HeathTrackApp> {
  int selectedIndex = 0;
  final List<Widget> _children= [
      HomeScreen(),
    //Container(color: Colors.blueGrey,child: const Center(child: Text('home',))),
      Container(color: Colors.green,child: const Center(child: Text('map',))),
      Container(color: Colors.pink,child: const Center(child: Text('News'),),),
    //Container(color: Colors.yellow,child: const Center(child: Text('profile',))),
      ProfileScreen()
    ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context)=> Patient(name: "Khanh", sex: 'female', dateOfBirth: DateTime(2000,4,3)),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: _children[selectedIndex],
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              //color: Colors.black,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 25
                )]
            ),
            margin: EdgeInsets.only(right: 15,left:15,bottom:15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: BottomNavigationBar(
                items:  const [
                  BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
                  BottomNavigationBarItem(icon: Icon(Icons.map),label: 'Map'),
                  BottomNavigationBarItem(icon: Icon(Icons.newspaper),label: 'News'),
                  BottomNavigationBarItem(icon: Icon(Icons.person),label: 'User'),
                ],
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.grey,
                unselectedItemColor: Colors.black54,
                selectedItemColor: const Color(0xFFb1fcbc),
                currentIndex: selectedIndex,
                onTap: (index){
                  setState(() {
                    selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

