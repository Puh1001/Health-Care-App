import 'package:flutter/material.dart';
import 'package:heathtrack/widgets/phoneCall.dart';
import 'package:url_launcher/url_launcher.dart';
class SosScreen extends StatefulWidget {
  const SosScreen({super.key});

  @override
  State<SosScreen> createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen> {
  void showForm(){
    showModalBottomSheet(context: context,
        elevation: 5,
        isScrollControlled: true,
        builder: (_)=>Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            )
          ),
          width: MediaQuery.sizeOf(context).width,
          height: 270,
          child: Column(
            children: [
              Text('New emergency contact', style: TextStyle(
                fontSize: 20,
              ),),
              TextField(
                decoration: InputDecoration(
                  label: Text('Contact name'),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  label: Text('Phone number'),
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){}, 
                  child: Text('Add new'),
                  style: ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 30,vertical: 10)),
                    backgroundColor: MaterialStatePropertyAll(Colors.red),
                    foregroundColor: MaterialStatePropertyAll(Colors.white)
                  ),
              ),
            ],
          ),
        ));
  }
  void _makePhoneCall(String phoneNum) async {
    if (await canLaunchUrl(Uri(path: phoneNum,scheme: 'tel'))) {
      await launchUrl(Uri(path: phoneNum,scheme: 'tel'));
    } else {
      throw 'Could not launch ';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add,color: Colors.red,),
        shape: CircleBorder(),
        backgroundColor: Colors.white,
        onPressed: (){showForm();},
      ),
      backgroundColor: Color(0xfff48d8d),
      appBar: AppBar(
        centerTitle: true,
        foregroundColor: const Color(0xffe72c2c),
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(20),
                bottomLeft: Radius.circular(20))),
        title: Text('Emergency call',
        style: TextStyle(fontWeight: FontWeight.bold,),),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            PhoneCall(title: 'Ambulance', number: '115',
              icon: Icons.medical_services_rounded,
              ontap: (){
                _makePhoneCall('115');
              },),
            PhoneCall(title: 'Fire fight',
              number: '114',icon: Icons.local_fire_department,
              ontap: (){
                _makePhoneCall('114');
              },),
            PhoneCall(title: 'police',
              number: '113',icon: Icons.local_police_outlined,
              ontap: (){
                _makePhoneCall('113');
              },),
          ],
        ),
      ),
    );
  }
}
