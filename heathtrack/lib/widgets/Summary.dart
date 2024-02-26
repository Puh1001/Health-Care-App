import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
class SummaryWG extends StatefulWidget {
  final String diagnose;
  final String advice;
  SummaryWG({this.diagnose = 'Great!',this.advice ='hmmm...',});

  @override
  State<SummaryWG> createState() => _SummaryWGState();
}

class _SummaryWGState extends State<SummaryWG> {
  var _temp;
  var _des;
  String weatherImage = 'images/cloudy.png';

  void getData() async {
    var url = Uri.https(
        'api.openweathermap.org',
        '/data/2.5/weather',
        {
          'q' : 'hà đông',
          'units' : 'metric',
          'appid' : 'e0ea7c2430957c0b90c7a6375a5f8cba',
          //'lang' : 'vi'
        }
    );

    var response = await http.get(url);

    setState(() {
      if (response.statusCode == 200) {
        String data = response.body;
        var decodeData = jsonDecode(data);
        _temp = decodeData['main']['temp'];
        _des = decodeData['weather'][0]['description'];
        weatherImage = getImageForWeatherCondition();
      }else{
        weatherImage = 'images/cloudy.png';
      }
    });
  }
  String getImageForWeatherCondition() {
    if (_des.contains('clear')) {
      return 'images/sun.png';
    } else if (_des.contains('storm')) {
      return 'images/storm.png';
    } else if (_des.contains('rain')) {
      return 'images/raining.png';
    } else if (_des.contains('overcast')) {
      return 'images/gloomy.png';
    } else if (_des.contains('snow')) {
      return 'images/snow.png';
    } else {
      return 'images/cloudy.png';
    }
  }
  @override
  Widget build(BuildContext context) {
    getData();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Summary', style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
          Container(
            height: 150,
            margin: const EdgeInsets.only(top:10),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              color: Color(0xFFDFEBEB),
                //border: Border.all(color: Colors.white.withOpacity(0.5),width: 1),
                boxShadow:  [BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0,3),
                ),]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text((_temp==null)?'null':'${_temp.toInt()}°C',style: const TextStyle(
                        fontSize: 25,
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold
                      ),),
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset(weatherImage),
                      ),
                      Text('${_des}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.blueGrey,
                      ),),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  width: 2,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(20)
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(widget.diagnose,style: TextStyle(fontSize: 30,color: Color(
                          0xff5eca79),fontWeight: FontWeight.bold),),
                      Text(widget.advice,style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500
                      ),)
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}