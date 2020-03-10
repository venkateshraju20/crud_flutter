import 'dart:io';

import 'package:flutter/material.dart';

import 'package:dio/dio.dart';

import 'package:crud_flutter/src/utils/endpoints.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';

Future requestUserLogin(
    BuildContext context, String email, String password) async {
  Map<String, dynamic> body = {
    'email': email,
    'password': password,
  };
  Response response;
  Dio dio = new Dio();

  try {
    response = await dio.post(USER_SIGNIN_URL,
        data: body,
        options:
            new Options(contentType: ContentType.parse("application/json")));
    print("Login data: ${response.data}");
    showSavingLoader(context, false, "Logging");
    if (response.statusCode == 200) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          '/homeScreen', (Route<dynamic> route) => false);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      showSavingLoader(context, false, "Logging");
      print("Error login: ${e.response.data}");
    }
  }
}
