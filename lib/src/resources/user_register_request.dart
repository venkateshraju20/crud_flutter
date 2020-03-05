import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/src/ui/response_model.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/endpoints.dart';
import 'package:flutter/material.dart';

Future registerUserAPI(
  BuildContext context,
  String email,
  String password,
  String mobile,
  String profession,
  String firstName,
  String lastName,
) async {
  Map<String, String> body = {
    'email': email,
    'password': password,
    'mobile': mobile,
    'profession': profession,
    'firstName': firstName,
    'lastName': lastName,
  };

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(USER_SIGNUP_URL));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  final responseJson = json.decode(reply);
  var responseMessage = new ResponseMessageModel.fromJson(responseJson);

  //showWaitLoader(context, false, "Please wait");
  if (response.statusCode == 200) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginScreen', (Route<dynamic> route) => false);
    showDialogButton(context, "Account created", responseMessage.message, "OK");
  } else if (response.statusCode == 409) {
    showDialogButton(context, "Error", responseMessage.message, "OK");
  } else {
    showDialogButton(
        context, "Error", "Error creating account. Please try again.", "OK");
  }
}
