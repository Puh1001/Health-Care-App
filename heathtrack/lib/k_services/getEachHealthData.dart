import 'dart:ffi';

import 'package:heathtrack/models/heathData.dart';

class GetEachHealthData{

  List <Data> getListHeartRate(List<HeathData> listHeathData){
    List <Data> listHeartRate = [];
    for (var i in listHeathData){
      listHeartRate.add(Data(value: double.parse(i.heartRate.toString()), time: formatDate(i.timestamp)));
    }
     return listHeartRate;
  }
  double formatDate(String timeString){ //2024-03-08T04:38:34.124Z
    double hour = double.parse(timeString.substring(11,13));
    double minute = double.parse(timeString.substring(14,16));
    double second = double.parse(timeString.substring(17,19));
    return hour + minute/60 + second/3600;
  }
}
class Data {
  double value;
  double time;
  Data({required this.value, required this.time});
}
