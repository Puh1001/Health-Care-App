import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:heathtrack/constants/errorHandling.dart';
import 'package:heathtrack/constants/utils.dart';
import 'package:heathtrack/models/profile.dart';
import 'package:heathtrack/providers/userProvider.dart';
import 'package:heathtrack/services/authService.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProfileService {
  void addProfile({
    required BuildContext context,
    required String gender,
    required List<File> image,
    required String dateOfBirth,
    required String phoneNumber,
    required double weight,
    required double height,
    required String userId,
    required String bloodtype,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('ddvpwwiaj', 'qjers8b8');
      String imgUrl;
      CloudinaryResponse res = await cloudinary
          .uploadFile(CloudinaryFile.fromFile(image[0].path, folder: userId));
      imgUrl = res.secureUrl;

      Proflie proflie = Proflie(
        dateOfBirth: dateOfBirth,
        gender: gender,
        phoneNumber: phoneNumber,
        image: imgUrl,
        height: height,
        weight: weight,
        userId: userId,
        bloodType: bloodtype,
      );

      http.Response resp = await http.post(Uri.parse('$uri/api/add-profile'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: proflie.toJson());

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

  Future<Proflie?> fetchProfileData({
    required BuildContext context,
    required userId,
  }) async {
    final userProvider = Provider.of<UserProvider>(context);
    Proflie? profile;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/get-profile?userId=$userId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      httpErrorHandle(
          response: res,
          context: context,
          onSucess: () {
            dynamic data = jsonDecode(res.body);
              profile = Proflie(
                gender: data[0]['gender'],
                image: data[0]['image'],
                dateOfBirth: data[0]['dateOfBirth'],
                bloodType: data[0]['bloodType'],
                phoneNumber: data[0]['phoneNumber'],
                weight: double.parse(data[0]['weight'].toString()),
                height: double.parse(data[0]['height'].toString()),
                userId: userId,
              );
          });
    } catch (err) {
      showSnackBar(context, err.toString());
    }
    return profile;
  }
}
