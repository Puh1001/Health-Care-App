import 'package:flutter/material.dart';

class PatientCard extends StatelessWidget {
  PatientCard(
      {super.key,
      required this.name,
      this.age,
      required this.diagnose,
      required this.ontap,this.isWoman = false});

  String name;
  int? age;
  String diagnose;
  final Function ontap;
  var isWoman = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              offset: const Offset(0, 4),
              blurRadius: 10,
              color: Colors.black.withOpacity(0.1)
          )
        ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [ Color(0xFFFFFFFF),Color(0xFFFFFFFF),],

            ),
             borderRadius: BorderRadius.circular(20)),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: AspectRatio(
                aspectRatio: 1 / 1.2,
                child: Container(
                  decoration: BoxDecoration(
                   color: Colors.white.withOpacity(0.4),
                    image: DecorationImage(image: AssetImage(isWoman?'images/womanAvatar.png':'images/manAvatar.png',),fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (age == null) ? 'Age: No information' : 'Age: $age',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Diagnose: $diagnose',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                )
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(onPressed: (){}, icon: const Icon(Icons.settings,size: 30,),color: Colors.grey.shade600,),
                  TextButton(onPressed:(){}, child: const Text('Delete',style: TextStyle(color: Color(
                      0xffb93939)),))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
