import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/widgets/chart.dart';
class OxygenScreen extends StatefulWidget {

   const OxygenScreen({super.key});

  @override
  State<OxygenScreen> createState() => _OxygenScreenState();
}

class _OxygenScreenState extends State<OxygenScreen> {
  List <double> listData = [];

  addData(double data){
    setState(() {
      listData.add(data);
    });
  }
  double time = DateTime.now().hour.toDouble() +  DateTime.now().minute.toDouble()/60;
  double? currentValue ;
  double? maxValue ;
  double? minValue;
  double?  average ;
  @override
  Widget build(BuildContext context) {
    currentValue = listData.isEmpty?0:listData[listData.length-1];
    maxValue = listData.isEmpty?0:listData.reduce(max);
    minValue = listData.isEmpty?0:listData.reduce(min);
    average = listData.isEmpty?0:(listData.reduce((a, b) => a + b) / listData.length);
    return Scaffold(
      appBar: AppBar(title: const Text('Oxygen saturation'),),
      backgroundColor: const Color(0xffe0f7fc),
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
                      child: Icon(FontAwesomeIcons.o,color: Colors.blueAccent,size: 60,),
                    ),
                    Text("$currentValue %",style: const TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                  ],),
                  const SizedBox(height: 10,),
                 Chart(listData: listData),]
            ),
          ),

          const SizedBox(height: 20,),
          DataBar(name: 'Current oxygen saturation',value: '$currentValue',),
          DataBar(name: 'Average oxygen saturation',value: '${(average! * pow(10, 1)).round() / pow(10, 1)}',),
          DataBar(name: 'Max oxygen saturation',value: '$maxValue',),
          DataBar(name: 'Min oxygen saturation',value: '$minValue',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent ),
            onPressed: (){
              Random ran = Random();
              addData((90 + ran.nextInt(11)).toDouble());
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



