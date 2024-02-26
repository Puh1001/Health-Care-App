import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/widgets/chart.dart';
class GlucoseLevelScreen extends StatefulWidget {

  const GlucoseLevelScreen({super.key});

  @override
  State<GlucoseLevelScreen> createState() => _GlucoseLevelScreenState();
}

class _GlucoseLevelScreenState extends State<GlucoseLevelScreen> {
  List <double> listData = [];

  addData(double data){
    setState(() {
      listData.add(data);
    });
  }
  double time = DateTime.now().hour.toDouble() +  DateTime.now().minute.toDouble()/60;
  double currentValue =0;
  double maxValue =0;
  double minValue =0;
  double  average =0;
  @override
  Widget build(BuildContext context) {
    currentValue = listData.isEmpty?0:listData[listData.length-1];
    maxValue = listData.isEmpty?0:listData.reduce(max);
    minValue = listData.isEmpty?0:listData.reduce(min);
    average = listData.isEmpty?0:(listData.reduce((a, b) => a + b) / listData.length);
    return Scaffold(
      appBar: AppBar(title: const Text('Glucose level'),),
      backgroundColor: const Color(0xffd8d2f3),
      body: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(bottomRight:Radius.circular(20) ,bottomLeft: Radius.circular(20))
            ),

            child:  Column(
                children:[
                  const SizedBox(height: 20,),
                  Row(children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(FontAwesomeIcons.g,color: Colors.purpleAccent,size: 60,),
                    ),
                    Text("$currentValue mg/DL",style: const TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                  ],),
                  const SizedBox(height: 10,),
                  Chart(listData: listData,max:maxValue),]
            ),
          ),

          const SizedBox(height: 20,),
          DataBar(name: 'Current Glucose level',value: '$currentValue',),
          DataBar(name: 'Average Glucose level',value: '${(average * pow(10, 1)).round() / pow(10, 1)}',),
          DataBar(name: 'Max Glucose level',value: '$maxValue',),
          DataBar(name: 'Min Glucose level',value: '$minValue',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.purpleAccent ),
            onPressed: (){
              Random ran = Random();
              addData((35 + ran.nextInt(6)).toDouble());
            },
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text('Connect to device',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            ),),
        ],
      ),
    );
  }
}



