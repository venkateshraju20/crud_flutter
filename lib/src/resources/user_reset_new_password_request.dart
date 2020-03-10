import 'dart:convert';
import 'dart:io';

import 'package:crud_flutter/src/ui/response_model.dart';
import 'package:crud_flutter/src/utils/dialog_box.dart';
import 'package:crud_flutter/src/utils/endpoints.dart';
import 'package:crud_flutter/src/utils/save_loader.dart';
import 'package:flutter/material.dart';

Future submitNewPasswordAPI(
    BuildContext context, String password, String email) async {
  Map<String, String> body = {'password': password, 'email': email};

  HttpClient httpClient = new HttpClient();
  HttpClientRequest request =
      await httpClient.postUrl(Uri.parse(USER_RESET_PASSWORD_URL));
  request.headers.set('content-type', 'application/json');
  request.add(utf8.encode(json.encode(body)));
  HttpClientResponse response = await request.close();
  String reply = await response.transform(utf8.decoder).join();
  final responseJson = json.decode(reply);
  print("Forgot reset password res: $responseJson");
  var responseMessage = new ResponseMessageModel.fromJson(responseJson);

  showSavingLoader(context, false, "Saving");

  if (response.statusCode == 200) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginScreen', (Route<dynamic> route) => false);
    showDialogButton(context, "Success", responseMessage.message, "OK");
  } else {
    Navigator.of(context).pushNamedAndRemoveUntil(
        '/loginScreen', (Route<dynamic> route) => false);
    showDialogButton(context, "Error",
        "Error resetting your password. Please try again.", "OK");
  }
}
