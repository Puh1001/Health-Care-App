import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:provider/provider.dart';
import 'updateInfoView.dart';

class PatientCard extends StatefulWidget {
  PatientCard(
      {super.key,
      required this.name,
      this.age,
      required this.diagnose,
      required this.ontap,
      this.isWoman = false,
      required this.patient});

  String name;
  int? age;
  String diagnose;
  final Function ontap;
  var isWoman = false;
  Patient patient;

  @override
  State<PatientCard> createState() => _PatientCardState();
}

class _PatientCardState extends State<PatientCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.ontap();
      },
      child: Container(
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: const Offset(0, 4),
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.1))
            ],
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFFFFFFF),
              ],
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
                    image: DecorationImage(
                        image: AssetImage(
                          widget.isWoman
                              ? 'images/womanAvatar.png'
                              : 'images/manAvatar.png',
                        ),
                        fit: BoxFit.cover),
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
                      widget.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      (widget.age == null)
                          ? 'Age: No information'
                          : 'Age: ${widget.age}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Diagnose: ${widget.diagnose}',
                      style: const TextStyle(fontSize: 16),
                    )
                  ],
                )),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => UpdateInfoView(
                                patientId: widget.patient.id,
                              )));
                    },
                    icon: const Icon(
                      Icons.settings,
                      size: 30,
                    ),
                    color: Colors.grey.shade600,
                  ),
                  TextButton(
                      onPressed: () {},
                      child: const Text(
                        'Delete',
                        style: TextStyle(color: Color(0xffb93939)),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
