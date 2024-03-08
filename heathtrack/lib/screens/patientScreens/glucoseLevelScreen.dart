import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:heathtrack/widgets/chart.dart';

import '../../k_services/diagnoseEngine.dart';
import '../../k_services/getEachHealthData.dart';
import '../../widgets/diagnoseBar.dart';
import 'checkGlucoseLevel.dart';
class GlucoseLevelScreen extends StatefulWidget {

  const GlucoseLevelScreen({super.key});

  @override
  State<GlucoseLevelScreen> createState() => _GlucoseLevelScreenState();
}

class _GlucoseLevelScreenState extends State<GlucoseLevelScreen> {
  List <Data> listData = [];

  addData(Data data){
    setState(() {
      listData.add(data);
    });
  }
  double? currentValue ;
  double? maxValue ;
  double? minValue;
  double?  average ;
  @override
  Widget build(BuildContext context) {
    currentValue = listData.isEmpty?0:listData[listData.length-1].value;
    maxValue = listData.isEmpty?0:listData.reduce((curr, next) => curr.value > next.value ? curr : next).value;
    minValue = listData.isEmpty?0:listData.reduce((curr, next) => curr.value < next.value ? curr : next).value;
    average = listData.isEmpty?0:(listData.map((data) => data.value).reduce((a, b) => a + b)/ listData.length);
    return Scaffold(
      appBar: AppBar(title: const Text('Glucose level'),),
      backgroundColor: const Color(0xffd8d2f3),
      body: SingleChildScrollView(
        child: Column(
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
                    Chart(listData: listData),]
              ),
            ),
            const SizedBox(height: 20,),
            DiagnoseBar(diagnose: DiagnosisEngine.diagnoseBloodGlucoseLevelIssue(currentValue!)),
            DataBar(name: 'Current Glucose level',value: '$currentValue',),
            DataBar(name: 'Average Glucose level',value: '${(average! * pow(10, 1)).round() / pow(10, 1)}',),
            DataBar(name: 'Max Glucose level',value: '$maxValue',),
            DataBar(name: 'Min Glucose level',value: '$minValue',),
            const SizedBox(height: 50),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor:Colors.purpleAccent ),
              onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context)=>CheckGlucoseLevel()));
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 50),
                child: Text('Check',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
              ),),
            
          ],
        ),
      ),
    );
  }
}



