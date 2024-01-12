import 'package:flutter/material.dart';
//
// class Metrics extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<Patient>(
//       builder: (BuildContext context, patient,child){
//       return Container(
//         margin: EdgeInsets.all(15),
//         padding: EdgeInsets.only(top:20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Health Metrics",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
//             SizedBox(height: 5,),
//             Row(
//               children: [
//                 MatricPart(Icon(Icons.favorite,color: Colors.redAccent,size: 60,),"Heart","${patient.heartRate}",HomeScreen(),),
//                 SizedBox(width: 15,),
//                 MatricPart(Icon(Icons.check_box_outline_blank,color: Colors.lightGreen,size: 60,),"BAC","${patient.bloodPressure}",HomeScreen(),),
//               ],
//             ),
//             SizedBox(height: 15,),
//             Row(
//               children: [
//                 MatricPart(Icon(Icons.heat_pump,color: Colors.yellow,size: 60,),"ABC","${patient.oxygenSaturation}",TemperatureScreen(),),
//                 SizedBox(width: 15,),
//                 MatricPart(Icon(Icons.air,color: Colors.pink,size: 60,),"Body\nTemperature","${patient.bodyTemperature}",TemperatureScreen(),),
//               ],
//             ),
//           ],
//         ),
//       );}
//     );
//   }
// }
class Metrics extends StatelessWidget {
  final Icon icon;
  final String label;
  final String metric;
  final String unit;
  Function? ontap;
  final Color color;
  Metrics(this.icon, this.label, this.metric, this.unit,{required this.ontap,this.color = Colors.white});
  @override

  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: (){
          print("tap ${label}");
          ontap!();
          },
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10),
              boxShadow: const [BoxShadow(
                color: Color(0xC7CACACA),
                blurRadius: 8,
                offset: Offset(0,3),
              ),]
          ),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Positioned(top:15,left:15,child: icon),
              Positioned(bottom:10,left:15,child: Text(label,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,),textAlign: TextAlign.left,)),
              Positioned(
                top:20,
                right:20,
                child:
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(metric,
                          style: TextStyle(color: Colors.blueGrey,fontSize: 30,fontWeight: FontWeight.bold,)
                      ),
                      Text(unit,style: TextStyle(fontSize: 16),)
                    ],
                  ),)
            ],
          ),
        )
      ),
    );
  }
}

