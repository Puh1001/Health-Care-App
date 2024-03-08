import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:heathtrack/constants/errorHandling.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/addPatientProfile.dart';
import 'package:heathtrack/models/heathData.dart';
import 'package:heathtrack/models/patientInWatcher.dart';
import 'package:heathtrack/models/user.dart';
import 'package:heathtrack/objects/patient.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/services/authService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class WatcherService {
  void addPatient({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
    required String type,
    required String age,
    required String familyCode,
    required String watcherId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      PatientInWatcher patientInWatcher = PatientInWatcher(
        name: name,
        email: email,
        password: password,
        //age: age,
        type: type,
        familyCode: familyCode,
        watcherId: watcherId,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/register'),
        body: patientInWatcher.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          showSnackBar(context, 'Account created!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void addPatientProfile({
    required BuildContext context,
    required String name,
    required DateTime dateOfBirth,
    required String gender,
    required String phoneNumber,
    required String email,
    required double height,
    required double weight,
    required String bmi,
    required File image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('ddvpwwiaj', 'qjers8b8');
      String imgUrl;
      CloudinaryResponse res = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image.path, folder: name));
      imgUrl = res.secureUrl;

      AddPatientProfile addPatientProfile = AddPatientProfile(
        name: name,
        dateOfBirth: dateOfBirth,
        gender: gender,
        phoneNumber: phoneNumber,
        image: imgUrl,
        email: email,
        height: height,
        weight: weight,
        bmi: bmi,
      );

      http.Response resp =
          await http.post(Uri.parse('$uri/patient/add-patient-profile'),
              headers: {
                'Content-Type': 'application/json; charset=UTF-8',
                'x-auth-token': userProvider.user.token,
              },
              body: addPatientProfile.toJson());

      httpErrorHandle(
        response: resp,
        context: context,
        onSucess: () {
          showSnackBar(context, 'Patient profile add sucessfully !!');
          Navigator.pop(context);
        },
      );
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  }

  // GET ALL PATIENT
  Future<List<PatientInWatcher>> fetchAddressPatient({
    required BuildContext context,
    required watcherId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    final watcherId = userProvider.user.id;
    List<PatientInWatcher> patientList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/watcher/get-all-patient?watcherId=$watcherId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            List <dynamic> data = jsonDecode(res.body);
            for (var patient in data) {
              patientList.add(
                PatientInWatcher(
                    id: patient['_id'] ,
                    name: patient['name'],
                    email: patient['email'],
                    password: patient['password'],
                    type: patient['type'],
                    //age: patient['age'],
                    familyCode: patient['familyCode'],
                    watcherId: patient['watcherId']
                )
              );
            }
          });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return patientList;
  }

  // GET ALL HEATH DATA
  Future<List<HeathData>> fetchHeathDataInWatcher(
    BuildContext context,
    userId,
  ) async {
    final userProvider = Provider.of<UserProvider>(context);
    List<HeathData> heathDataList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-heath-data?userId=$userId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            List<dynamic> data = jsonDecode(res.body);
            print('data length ${data[7]}');
            for (var health in data) {
              print(health);
              heathDataList.add(HeathData(
                  heartRate: health['heartRate'],
                  spb: health['spb'],
                  dbp: health['dbp'],
                  oxygen: double.parse(health['oxygen'].toString()),
                  temperature: double.parse(health['temperature'].toString()),
                  glucose: health['glucose'],
                  step: health['step'],
                  timestamp: health['timestamp'],
                  userId: health['userId']));
            }
          });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
  print(heathDataList.length);
    return heathDataList;
  }
}
