import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:crud_flutter/src/ui/response_model.dart';
import 'package:crud_flutter/src/utils/endpoints.dart';

Future<bool> requestForgotAPI(BuildContext context, String email) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  Map<String, dynamic> body = {'email': email};

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(USER_RESET_FIND_URL));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  final responseJson = json.decode(reply);
  var emailAddress = ResponseMessageModel.fromJson(responseJson);

  if (response.statusCode == 200) {
    await preferences.setString("authVerifyEmail", emailAddress.message);
    return true;
  } else {
    return false;
  }
}
