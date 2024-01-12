import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class TemperatureScreen extends StatelessWidget {
  const TemperatureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Body temperature'),),
      backgroundColor: const Color(0xfff2e8e1),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomRight:Radius.circular(20) ,bottomLeft: Radius.circular(20))
            ),
           
            child: Column(
              children:[
              const SizedBox(height: 20,),
                const Row(children: [
                  Icon(Icons.thermostat,color: Colors.red,size: 80,),
                  Text("37.3",style: TextStyle(fontSize: 45,color: Colors.blueGrey,fontWeight: FontWeight.bold),)
                ],),
                const SizedBox(height: 10,),
                // const AspectRatio(
                //   aspectRatio: 2,
                //   child: TemperatureBarChart(),
                // ),
                TemperatureChart(),]
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
          const TemperatureInfo(name: 'Current temperature',value: '37.3',),
          const TemperatureInfo(name: 'Average temperature',value: '37.1',),
          const TemperatureInfo(name: 'Max temperature',value: '37.9',),
          const TemperatureInfo(name: 'Min temperature',value: '36.8',),
          const SizedBox(height: 50),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor:Colors.deepOrangeAccent ),
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
class TemperatureChart extends StatelessWidget {
  //List<FlSpot> tdata;
  // TemperatureChart({super.key, required this.tdata});
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 24,
            minY: 35,
            maxY: 42,
            backgroundColor: Colors.white,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  FlSpot(0, 36.5),
                  FlSpot(1, 36.3),
                  FlSpot(2, 36.8),
                  FlSpot(4, 37.0),
                  FlSpot(8, 36.6),
                  FlSpot(10, 36.5),
                  FlSpot(16, 36.6),
                  FlSpot(18, 36.8),
                  FlSpot(20, 36.9),
                  FlSpot(24, 36.2),
                ],
                isCurved: false,
                color: Colors.pink,
                dotData: FlDotData(show: false),
              ),
            ],
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
              ),),
              topTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: false,
              ),),
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
          ),
        ),
      ),
    );
  }
}

class TemperatureInfo extends StatelessWidget {
  const TemperatureInfo({super.key, required this.name,required this.value});
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


