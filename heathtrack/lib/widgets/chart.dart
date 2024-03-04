import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
class Data{
  double time;
  double value;
  Data({required this.value, required this.time });
}
class Chart extends StatelessWidget {
  List <Data> listData ;
  Chart({super.key, required this.listData});
  @override
  Widget build(BuildContext context) {
    double maxVal = listData.isEmpty?0:listData.reduce((curr, next) => curr.value > next.value ? curr : next).value;
    double minVal = listData.isEmpty?0:listData.reduce((curr, next) => curr.value < next.value ? curr : next).value;
    double maxTime = listData.isEmpty?0:listData.reduce((curr, next) => curr.time > next.time ? curr : next).time;
    double minTime = listData.isEmpty?0:listData.reduce((curr, next) => curr.time < next.time ? curr : next).time;
    return AspectRatio(
      aspectRatio: 2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: LineChart(
          LineChartData(
            minX: double.parse(minTime.toStringAsFixed(1)),
            maxX: double.parse(maxTime.toStringAsFixed(1)),
            minY: minVal,
            maxY: maxVal,
            backgroundColor: Colors.white,
            lineBarsData:
            [
              LineChartBarData(
                //spots: listData.map((e) => FlSpot(DateTime.now().hour.toDouble() +  DateTime.now().minute.toDouble()/60,e)).toList(),
                spots: listData.map((e) => FlSpot(e.time,e.value)).toList(),
                isCurved: false,
                color: Colors.pink,
                dotData: const FlDotData(show: true),
              ),
            ],

            titlesData: const FlTitlesData(
              bottomTitles: AxisTitles(sideTitles: SideTitles(
                showTitles: true,
                //getTitlesWidget: bottomTitleWidgets
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
Widget bottomTitleWidgets(double value, TitleMeta meta) {
  const style = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  Widget text;
  switch (value.toInt()) {
    case 2:
      text = const Text('SEPT', style: style);
      break;
    case 7:
      text = const Text('OCT', style: style);
      break;
    case 12:
      text = const Text('DEC', style: style);
      break;
    default:
      text = const Text('');
      break;
  }

  return SideTitleWidget(
    axisSide: meta.axisSide,
    space: 10,
    child: text,
  );
}