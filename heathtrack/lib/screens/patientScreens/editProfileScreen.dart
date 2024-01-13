import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../objects/patient.dart';
class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late DateTime date = Provider.of<Patient>(context, listen: false).dateOfBirth;
  @override
  Widget build(BuildContext context) {
    return Consumer<Patient>(
      builder: (BuildContext context, patient,child) {

        TextEditingController nameController= TextEditingController(text: patient.name);
        TextEditingController phoneNumberController=TextEditingController(text: patient.phoneNumber);
        TextEditingController emailController=TextEditingController(text: patient.email);
      return Scaffold(
        body: Stack(
            children:[
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 100,),
                      Text('Name',style: TextStyle(fontSize: 18),),
                      TextField(controller: nameController,
                        style: TextStyle(fontSize: 20,color: Colors.blueGrey),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text('Date of birth',style: TextStyle(fontSize: 18),),
                      GestureDetector(onTap: ()async{
                        final DateTime? dateTime = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime(2025)
                        );

                        if (dateTime!=null){
                          date = dateTime;
                            setState(() {
                              date = dateTime;print (date);
                            });
                        }
                      },
                        child:
                        Text("${DateFormat('dd/MM/yyyy').format(date)}",
                          style: TextStyle(fontSize: 18,color: Colors.blueGrey),
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text('Phone number',style: TextStyle(fontSize: 18),),
                      TextField(controller: phoneNumberController,
                        style: TextStyle(fontSize: 20,color: Colors.blueGrey),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),),
                      SizedBox(height: 15,),
                      Text('Email',style: TextStyle(fontSize: 18),),
                      TextField(controller: emailController,

                        style: TextStyle(fontSize: 20,color: Colors.blueGrey),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(15, 5, 15, 5),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                        ),)
                    ],
                  ),),
              ),
              Container(color: Colors.black,height: 80,),
              Positioned(
                top:40,
                left: 10,
                child: TextButton(
                  onPressed: (){Navigator.pop(context);},
                  child: const Text('Back',style: TextStyle(color: Colors.blueAccent,fontSize: 20),),),
              ),
              Positioned(
                top:40,
                right: 10,
                child: TextButton(
                  onPressed: (){
                    print(date);
                    patient.updatePatientInfo(
                      name:nameController.text,
                      phoneNumber: phoneNumberController.text,
                      email: emailController.text,
                      dateOfBirth: date,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Done',style: TextStyle(color: Colors.blueAccent,fontSize: 20),),),
              )
            ]
        ),
      ); },
    );
  }
}

