import 'package:flutter/material.dart';
import 'package:heathtrack/constants/errorHandling.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/patientInWatcher.dart';
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
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      PatientInWatcher patientInWatcher = PatientInWatcher(
        name: name,
        email: email,
        password: password,
        type: type,
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
}
