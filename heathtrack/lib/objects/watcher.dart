import 'package:flutter/cupertino.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/objects/theme.dart';

import '../models/user.dart';

class Watcher extends User {
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? gender;
  final List<Patient> patientList;

  Watcher({
    required String id,
    required String name,
    required String email,
    required String password,
    required String familyCode,
    required String address,
    required String type,
    required String token,
    this.dateOfBirth,
    this.phoneNumber,
    this.gender,
    required this.patientList,
  }) : super(
    id: id,
    name: name,
    email: email,
    password: password,
    familyCode: familyCode,
    address: address,
    type: type,
    token: token,
  );
}

// class Watcher with ChangeNotifier{
//   String name;
//   String id;
//   DateTime? dateOfBirth;
//   String? gender = 'No information';
//
//   String? phoneNumber;
//   String? email;
//
//   var theme = MyColor();
//   var lang = MyLanguage();
//   bool settingDarkmode = false;
//   bool settingLanguage = true;
//   List<Patient> listPatient = [];
//   Watcher({
//     required this.name,
//     this.id = '',
//     this.dateOfBirth,
//     this.gender,
//     this.phoneNumber,
//     this.email,
//
//   });
//   set nname(String newname){
//     name = newname;
//     notifyListeners();
//   }
//   void updateWatcherInfo({
//     String? name,
//     DateTime? dateOfBirth,
//     String? sex,
//     String? phoneNumber,
//     String? email,
//   }) {
//     this.name = name ?? this.name;
//     this.dateOfBirth = dateOfBirth ?? this.dateOfBirth;
//     this.gender = gender ?? this.gender;
//     this.phoneNumber = phoneNumber ?? this.phoneNumber;
//     this.email = email ?? this.email;
//     notifyListeners();
//   }
//   changeColor(bool isdark){
//     isdark? theme.setDark():theme.setLight();
//     settingDarkmode = isdark;
//     notifyListeners();
//   }
//   changeLang(bool isEng){
//     isEng? lang.changeToEng():lang.changeToVi();
//     settingLanguage = isEng;
//     notifyListeners();
//   }
// }