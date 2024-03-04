import 'package:flutter/material.dart';
import 'package:heathtrack/screens/watcherScreen/watcherHomeScreen.dart';
import 'package:heathtrack/screens/watcherScreen/watcherProfileScreen.dart';
class WatcherControlScreen extends StatefulWidget {
  const WatcherControlScreen({super.key});

  @override
  State<WatcherControlScreen> createState() => _WatcherControlScreenState();
}

class _WatcherControlScreenState extends State<WatcherControlScreen> {
  int selectedIndex = 0;
  final List<Widget> _children= [
    WatcherHomeScreen(),
    Container(color: Colors.blueGrey,child: const Center(child: Text('home',))),
    //Container(color: Colors.green,child: const Center(child: Text('map',))),
    WatcherProfileScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffececed),
      body: _children[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          //color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [BoxShadow(
                color: Colors.black.withOpacity(0.5),
                blurRadius: 25
            )]
        ),
        margin: EdgeInsets.only(right: 12,left:12,bottom:12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BottomNavigationBar(
            items:  const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.map),label: 'Map'),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'User'),
            ],
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            unselectedItemColor: Colors.black54,
            selectedItemColor: const Color(0xFF68E3B3),
            currentIndex: selectedIndex,
            onTap: (index){
              setState(() {
                selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
