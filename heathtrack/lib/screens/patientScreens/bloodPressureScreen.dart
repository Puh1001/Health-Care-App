import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/widgets/chart.dart';
class BloodPressureScreen extends StatefulWidget {

  const BloodPressureScreen({super.key});

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
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
      appBar: AppBar(title: const Text('Blood pressure'),),
      backgroundColor: const Color(0xffF0E6E0),
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
                      child: Icon(FontAwesomeIcons.droplet,color: Colors.red,size: 60,),
                    ),
                    Text("$currentValue mmHg",style: const TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                  ],),
                  const SizedBox(height: 10,),
                  Chart(listData: listData,max:maxValue),]
            ),
          ),

          const SizedBox(height: 20,),
          DataBar(name: 'Current Blood pressure',value: '$currentValue',),
          DataBar(name: 'Average Blood pressure',value: '${(average * pow(10, 1)).round() / pow(10, 1)}',),
          DataBar(name: 'Max Blood pressure',value: '$maxValue',),
          DataBar(name: 'Min Blood pressure',value: '$minValue',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.red ),
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


