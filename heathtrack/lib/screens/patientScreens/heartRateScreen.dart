import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/widgets/chart.dart';
class HeartRateScreen extends StatefulWidget {

  const HeartRateScreen({super.key});

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
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
      appBar: AppBar(title: const Text('Heart rate'),),
      backgroundColor: const Color(0xffD2F2DB),
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
                      child: Icon(FontAwesomeIcons.heartPulse,color: Colors.green,size: 60,),
                    ),
                    Text("$currentValue bpm",style: const TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                  ],),
                  const SizedBox(height: 10,),
                  Chart(listData: listData,max:maxValue),]
            ),
          ),

          const SizedBox(height: 20,),
          DataBar(name: 'Current Heart rate',value: '$currentValue',),
          DataBar(name: 'Average Heart rate',value: '${(average * pow(10, 1)).round() / pow(10, 1)}',),
          DataBar(name: 'Max Heart rate',value: '$maxValue',),
          DataBar(name: 'Min Heart rate',value: '$minValue',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.green ),
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



