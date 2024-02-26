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
        appBar: AppBar(
          title: Text('Edit infomation'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          actions: [
            TextButton(
                onPressed: (){
                  patient.updatePatientInfo(
                    name:nameController.text,
                    phoneNumber: phoneNumberController.text,
                    email: emailController.text,
                    dateOfBirth: date,
                  );
                  Navigator.pop(context);
                },
                child: Text('Done',style: TextStyle(color: Colors.blueAccent,fontSize: 20),)),
            const SizedBox(width: 10,)
          ],
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20,),
                TextField(controller: nameController,
                  style: const TextStyle(fontSize: 20,color: Colors.blueGrey),
                  decoration: const InputDecoration(
                    label: Text('Name',style: TextStyle(fontSize: 18)),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                      //border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))
                  ),
                ),
                SizedBox(height: 15,),
                Text('Date of birth',style: TextStyle(fontSize: 14),),
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
                        date = dateTime;
                      });
                  }
                },
                  child:
                  Text("${DateFormat('dd/MM/yyyy').format(date)}",
                    style: TextStyle(fontSize: 18,color: Colors.blueGrey),
                  ),
                ),
                Container(height: 0.8,color: Colors.black54,),
                const SizedBox(height: 15,),
                TextField(controller: phoneNumberController,
                  style: TextStyle(fontSize: 20,color: Colors.blueGrey),
                  decoration: const InputDecoration(
                    label: Text('Phone number',style: TextStyle(fontSize: 18),),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),),
                const SizedBox(height: 15,),
                TextField(controller: emailController,
                  style: const TextStyle(fontSize: 20,color: Colors.blueGrey),
                  decoration: const InputDecoration(
                    label: Text('Email',style: TextStyle(fontSize: 18),),
                    contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  ),)
              ],
            ),),
        ),
      ); },
    );
  }
}

