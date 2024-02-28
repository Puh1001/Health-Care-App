// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:heathtrack/constants/errorHandling.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/user.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/screens/watcherScreen/watcherControlScreen.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

String uri = 'http://192.168.0.113:8080';

class AuthService {
// REGISTER
  void registerUser({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String familyCode,
  }) async {
    try {
      User user = User(
          id: "",
          name: name,
          email: email,
          password: password,
          familyCode: familyCode,
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

  // LOGIN
  void loginUser({
    required BuildContext context,
    required String email,
    required String password,
    required String familyCode,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
          'familyCode': familyCode,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
      );
      print(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSucess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            WatcherControlScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}