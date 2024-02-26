

import 'package:flutter/material.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/screens/patientScreens/editProfileScreen.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../widgets/InforBar.dart';
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Patient>(builder:
    (BuildContext context,patient,child){
      return Stack(
        children: [

          SingleChildScrollView(
            child: Container(
              color: Color(0xfff7f7f7),
              padding: const EdgeInsets.only(top: 100),
              child: Column(
                children: [

                  Container(
                    margin: const EdgeInsets.only(bottom:10),
                    height: 100,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey,
                    ),
                  ),
                  Text("${shortenName("${patient.name}")}",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                  const SizedBox(height: 10,),
                  InforBar('Main Infomations', [
                    Infor('Name', "${patient.name}",onTouch: (value){patient.updateName(value);},),
                    Infor('Date of Birth', "${DateFormat('dd/MM/yyyy').format(patient.dateOfBirth)}",
                      onTouch: (value){ patient.updateDateOfBirth(value);},),
                    Infor('Gender', "${patient.sex}",
                      onTouch: (value){ patient.updateSex(value);},)
                  ]),
                  InforBar('Group Name', [
                    Infor('Phone number', "${patient.phoneNumber}",
                      onTouch: (value){ patient.updatePhoneNumber(value);},),
                    Infor('Email', "${patient.email}",
                      onTouch: (value){ patient.updateEmail(value);},),
                  ]),
                  InforBar('Body indicators', [
                    Infor('Height', '${patient.height} cm',
                      onTouch: (value){ patient.updateHeight(double.parse(value));},),
                    Infor('Weight', '${patient.weight} kg',
                      onTouch: (value){ patient.updateWeight(double.parse(value));},),
                    Infor('BMI', '',onTouch: (){},canEdit: false,)
                  ])
                ],
              ),
            ),
          ),
          Container(
            height: 85,
            decoration: BoxDecoration(
              color: Color(0xfff7f7f7),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)),
            ),),
          Positioned(
              top:50,
              right:20,
              child: TextButton(
                style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blueGrey.withOpacity(0.3)),
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(0))),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfileScreen(),
                    ),
                  );
                },
                child: Text('Edit',style: TextStyle(fontSize: 18,color: Colors.blueAccent),),)),
        ],
      );
    }
    );
  }
  String shortenName(String fullName){
    String shortenName;
    fullName = fullName.trim();
    if(fullName.contains(" ")){
      String startString = fullName.substring(0,fullName.indexOf(' '));
      String endString = fullName.substring(fullName.lastIndexOf(' ')+1);
      shortenName = "$startString $endString";
    } else {
      shortenName = fullName;
    }
    return shortenName;
  }
}
