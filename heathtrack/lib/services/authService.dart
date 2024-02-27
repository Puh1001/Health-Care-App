// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:heathtrack/constants/errorHandling.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/user.dart';
import 'package:http/http.dart' as http;

String uri = 'http://192.168.0.113:8080';

class AuthService {
// REGISTER
  void registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          address: "",
          type: "",
          token: "");

      http.Response res = await http.post(
        Uri.parse('$uri/api/register'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSucess: () {
          showSnackBar(context, 'Accout created!');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
