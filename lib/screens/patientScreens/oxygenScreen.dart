import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class OxygenScreen extends StatelessWidget {
  const OxygenScreen({super.key});

  @override
  Widget build(BuildContext context) {
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

            child: const Column(
                children:[
                  SizedBox(height: 20,),
                  Row(children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Icon(FontAwesomeIcons.o,color: Colors.blueAccent,size: 60,),
                    ),
                    Text("98.5 %",style: TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                  ],),
                  SizedBox(height: 10,),
                  // const AspectRatio(
                  //   aspectRatio: 2,
                  //   child: TemperatureBarChart(),
                  // ),
                  OxygenChart(),]
            ),
          ),
          // const SizedBox(height: 20,),
          // const Row(children: [
          //   Icon(Icons.thermostat,color: Colors.red,size: 80,),
          //   Text("37.3",style: TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
          // ],),
          // const SizedBox(height: 10,),
          // // const AspectRatio(
          // //   aspectRatio: 2,
          // //   child: TemperatureBarChart(),
          // // ),
          // TemperatureChart(),
          const SizedBox(height: 20,),
          const OxygenInfo(name: 'Current oxygen saturation',value: '98.5',),
          const OxygenInfo(name: 'Average oxygen saturation',value: '98.1',),
          const OxygenInfo(name: 'Max oxygen saturation',value: '99.0',),
          const OxygenInfo(name: 'Min oxygen saturation',value: '97.1',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.blueAccent ),
            onPressed: (){},
            child: const Padding(
              padding: EdgeInsets.all(15),
              child: Text('Connect to device',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white)),
            ),),
        ],
      ),
    );
  }
}
class OxygenChart extends StatelessWidget {
  const OxygenChart({super.key});

  //List<FlSpot> tdata;
  // TemperatureChart({super.key, required this.tdata});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 24,
            minY: 90,
            maxY: 100,
            backgroundColor: Colors.white,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 98),
                  FlSpot(1, 98),
                  FlSpot(2, 98.6),
                  FlSpot(4, 99),
                  FlSpot(8, 98.5),
                  FlSpot(10, 98.1),
                  FlSpot(16, 98.2),
                  FlSpot(18, 97.8),
                  FlSpot(20, 97.1),
                  FlSpot(24, 98.5),
                ],
                isCurved: false,
                color: Colors.pink,
                dotData: const FlDotData(show: false),
              ),
            ],
            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
              ),),
              topTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: false,
              ),),
            ),
            gridData: const FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}

class OxygenInfo extends StatelessWidget {
  const OxygenInfo({super.key, required this.name,required this.value});
  final String name;
  final String value;
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 20),
      margin: const EdgeInsets.only(right: 20,left: 20,top:10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: const TextStyle(fontSize: 18),),
          Text(value,style: const TextStyle(fontSize: 18),)
        ],
      ),
    );
  }
}


