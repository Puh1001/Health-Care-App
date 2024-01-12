import 'package:flutter/material.dart';
class SummaryWG extends StatelessWidget {
  final String diagnose;
  final String advice;
  final double temperature;
  SummaryWG({this.diagnose = 'Great!',this.advice ='hmmm...',this.temperature=0});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Summary', style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
          Container(
            height: 150,
            margin: const EdgeInsets.only(top:10),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            decoration:BoxDecoration(
              borderRadius:BorderRadius.circular(10),
              color: Colors.white,
                boxShadow: const [BoxShadow(
                  color: Color(0xC7CACACA),
                  blurRadius: 8,
                  offset: Offset(0,3),
                ),]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  flex: 2,
                    child:
                    Container(
                      margin: EdgeInsets.only(right:15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey
                      ),
                      //child: Text('CHART'),
                    )
                ),
                Expanded(
                    flex: 3,
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Container(
                              child:Text(diagnose,style: TextStyle(fontSize: 30,color: Colors.green,fontWeight: FontWeight.bold),),
                              margin: EdgeInsets.only(bottom:10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  //color: Colors.grey
                              ),
                            ),
                          ),
                          Text(advice,style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500
                          ),)
                        ],
                      ),
                    )
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}