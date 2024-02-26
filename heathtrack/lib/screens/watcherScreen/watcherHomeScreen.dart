import 'package:flutter/material.dart';
import 'package:heathtrack/widgets/patientCard.dart';

import '../../widgets/deviceCard.dart';
class WatcherHomeScreen extends StatefulWidget {
  const WatcherHomeScreen({super.key});

  @override
  State<WatcherHomeScreen> createState() => _WatcherHomeScreenState();
}

class _WatcherHomeScreenState extends State<WatcherHomeScreen> {
  bool mySwitch = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      body: Column(
        children: [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(width: 20,),
                  CircleAvatar(
                    radius: 30.0, // Đặt bán kính của hình tròn
                    //backgroundImage: AssetImage('assets/avatar_image.jpg'), // Đặt hình ảnh
                  ),
                  SizedBox(width: 10,),
                  Text('Username',
                    style: TextStyle(fontWeight: FontWeight.bold,
                    fontSize: 24
                    ),)
                ],
              ),
              IconButton(onPressed: (){}, icon: Icon(Icons.settings,size: 35,))
            ],
          ),
          const SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              mySwitch = true;
                            });
                            },
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: mySwitch?Colors.grey:Colors.transparent
                            ),
                            child: Text('list patients',textAlign: TextAlign.center,),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(

                          onTap: (){
                            mySwitch = false;
                            setState(() {
                          });},
                          child: Container(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            decoration:BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: !mySwitch?Colors.grey:Colors.transparent
                            ),
                            child: Text('list devices',textAlign: TextAlign.center,),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                mySwitch?PatientCard():DeviceCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
