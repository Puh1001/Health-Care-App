import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class Chart extends StatelessWidget {
  List <double> listData ;
  double max;
  Chart({super.key, required this.listData,this.max = 100});
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
            minY: listData.isEmpty?0:listData.reduce(min),
            maxY: max,
            backgroundColor: Colors.white,
            lineBarsData:
            [
              LineChartBarData(
                spots: listData.map((e) => FlSpot(DateTime.now().hour.toDouble() +  DateTime.now().minute.toDouble()/60,e)).toList(),
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

class DataBar extends StatelessWidget {
  const DataBar({super.key, required this.name,required this.value});
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